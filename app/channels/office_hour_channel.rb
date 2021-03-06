class OfficeHourChannel < ApplicationCable::Channel
  def subscribed
    stream_from "office_hour_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Rails.logger.info data
    if data["op"] == "enqueue"
      entry_args = {office_hour_id: data["ohID"], student: data["name"], description: data["desc"], creator_id: connection.session.id}
      if connection.current_user
        qe = connection.current_user.queue_entry.create!(entry_args)
      else
        qe = QueueEntry.create!(entry_args)
      end
      ActionCable.server.broadcast "office_hour_channel", "ohID": data["ohID"], op: "enqueue", qe_id: qe.id, name: data["name"], desc: data["desc"], start_time: qe.created_at.strftime("%Y-%m-%dT%H:%M:%S+00:00"), creator: qe.creator_id, oh_user: qe.office_hour.user.id
    elsif data["op"] == "dequeue"
      qe = QueueEntry.find(data["qeID"])
      if (connection.current_user && qe.office_hour.user == connection.current_user) or (qe.creator_id.eql? connection.session.id.to_s)
        QueueEntry.destroy(data["qeID"])
        Chat.where(queue_entry_id: data["qeID"]).delete_all
        ActionCable.server.broadcast "office_hour_channel", "ohID": data["ohID"], op: "dequeue", qeID: data["qeID"]
      end
    elsif data["op"] == "refresh"
      ActionCable.server.broadcast "office_hour_channel", op: "refresh"
    elsif data["op"] == "show_thread"
      queue_entry = QueueEntry.find(data["qeID"]).as_json
      chats = Chat.where(queue_entry_id: data["qeID"]).as_json
      ActionCable.server.broadcast "office_hour_channel", op: "show_thread", ohID: data["ohID"], qeID: data["qeID"], qe: queue_entry, chats: chats, windowID: data["windowID"]
    elsif data["op"] == "send_msg"
      chat = Chat.create!("name": data["name"], "msg": data["msg"], "office_hour_id": data["ohID"], "queue_entry_id": data["qeID"])
      num_chats = Chat.where(queue_entry_id: data["qeID"]).length
      ActionCable.server.broadcast "office_hour_channel", op: "send_msg", ohID: data["ohID"], qeID: data["qeID"], chat: chat, num_chats: num_chats
    else
      # Unimplemented
    end
  end
end

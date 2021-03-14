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
      entry_args = {office_hour_id: data["ohID"], student: data["name"], description: data["desc"]}
      if connection.current_user
        qe = connection.current_user.queue_entry.create!(entry_args)
      else
        qe = QueueEntry.create!(entry_args)
      end
      ActionCable.server.broadcast "office_hour_channel", "ohID": data["ohID"], op: "enqueue", qe_id: qe.id, name: data["name"], desc: data["desc"], start_time: qe.created_at
    elsif data["op"] == "dequeue"
      qe = QueueEntry.find(data["qeID"])
      if connection.current_user && qe.office_hour.user == connection.current_user
        QueueEntry.destroy(data["qeID"])
        ActionCable.server.broadcast "office_hour_channel", "ohID": data["ohID"], op: "dequeue", qeID: data["qeID"]
      end
    elsif data["op"] == "refresh"
      ActionCable.server.broadcast "office_hour_channel", op: "refresh"
    else
      # Unimplemented
    end
  end
end

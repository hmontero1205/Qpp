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
      qe = QueueEntry.create!(oh_id: data["ohID"], student: data["name"], description: data["desc"])
      ActionCable.server.broadcast "office_hour_channel", op: "enqueue", qe_id: qe.id, name: data["name"], desc: data["desc"], start_time: qe.created_at
    elsif data["op"] == "dequeue"
      QueueEntry.destroy(data["qeID"])
      ActionCable.server.broadcast "office_hour_channel", op: "dequeue", qeID: data["qeID"]
    else
      # Unimplemented
    end
  end
end

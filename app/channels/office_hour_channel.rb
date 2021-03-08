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
      ActionCable.server.broadcast "office_hour_channel", name: data["name"], desc: data["desc"], start_time: qe.created_at
    else
      # Unimplemented
    end
  end
end

class ZoomMeetingCreds < ActiveRecord::Migration[6.1]
  def change
    add_column :office_hours, :meeting_id, :text
    add_column :office_hours, :meeting_passcode, :text
  end
end

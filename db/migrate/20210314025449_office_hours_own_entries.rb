class OfficeHoursOwnEntries < ActiveRecord::Migration[6.1]
  def change
    remove_column :queue_entries, :oh_id
    add_reference :queue_entries, :office_hour, index: true, foreign_key: true, null: false
  end
end

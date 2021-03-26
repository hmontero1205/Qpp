class AddCreatorIdToQueueEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :queue_entries, :creator_id, :string
  end
end

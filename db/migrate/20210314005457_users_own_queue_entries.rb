class UsersOwnQueueEntries < ActiveRecord::Migration[6.1]
  def change
    add_reference :queue_entries, :user, index: true, foreign_key: true, null: true
  end
end

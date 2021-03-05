class CreateQueueEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :queue_entries do |t|
      t.text :student
      t.datetime :start_time
      t.text :description
      t.integer :oh_id

      t.timestamps
    end
  end
end

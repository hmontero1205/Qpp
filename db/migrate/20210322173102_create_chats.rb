class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :name
      t.string :msg
      t.bigint :office_hour_id
      t.bigint :queue_entry_id

      t.timestamps
    end
  end
end

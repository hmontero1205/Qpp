class CreateOfficeHours < ActiveRecord::Migration[5.0]
  def change
    create_table :office_hours do |t|
      t.text :host
      t.text :class
      t.datetime :time
      t.text :zoom_info

      t.timestamps null: false
    end
  end
end

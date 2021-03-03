class CreateOfficeHours < ActiveRecord::Migration
  def change
    create_table :office_hours do |t|
      t.string :host
      t.string :class
      t.datetime :time
      t.string :zoom_info

      t.timestamps null: false
    end
  end
end

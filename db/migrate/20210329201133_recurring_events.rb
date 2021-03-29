class RecurringEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :office_hours, :starts_on, :datetime
    add_column :office_hours, :ends_on, :datetime
    add_column :office_hours, :repeats_until, :date
    remove_column :office_hours, :time

    create_table "office_hour_recurrences", force: :cascade do |t|
      t.string "day_of_week" # TODO: This should be an enum
    end
    add_reference :office_hour_recurrences, :office_hour, index: true, foreign_key: true, null: false
    add_index :office_hour_recurrences, [:id, :day_of_week], :unique => true
  end
end

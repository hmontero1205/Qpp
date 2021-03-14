class UsersOwnOfficeHours < ActiveRecord::Migration[6.1]
  def change
    remove_column :office_hours, :email
    add_reference :office_hours, :user, index: true, foreign_key: true, null: false
  end
end

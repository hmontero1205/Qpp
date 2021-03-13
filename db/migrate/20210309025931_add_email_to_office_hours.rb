class AddEmailToOfficeHours < ActiveRecord::Migration[5.0]
  def change
    add_column :office_hours, :email, :string
  end
end

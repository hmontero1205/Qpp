class AddActiveToOfficeHours < ActiveRecord::Migration[6.1]
  def change
    add_column :office_hours, :active, :boolean
  end
end

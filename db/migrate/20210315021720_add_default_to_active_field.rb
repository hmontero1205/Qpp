class AddDefaultToActiveField < ActiveRecord::Migration[6.1]
  def change
    change_column :office_hours, :active, :boolean, default: false
  end
end

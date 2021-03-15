class ChangeDefaultToActiveField < ActiveRecord::Migration[6.1]
  def change
    change_column :office_hours, :active, :boolean, default: true
  end
end

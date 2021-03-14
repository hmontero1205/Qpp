class RenameClassField < ActiveRecord::Migration[5.0]
  def change
    rename_column :office_hours, :class, :class_name
  end
end

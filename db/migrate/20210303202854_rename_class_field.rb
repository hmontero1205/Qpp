class RenameClassField < ActiveRecord::Migration
  def change
    rename_column :office_hours, :class, :class_name
  end
end

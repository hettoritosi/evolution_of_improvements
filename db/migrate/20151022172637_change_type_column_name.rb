class ChangeTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :import_logs, :type, :type_import
  end
end

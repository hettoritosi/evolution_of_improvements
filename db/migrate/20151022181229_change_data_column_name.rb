class ChangeDataColumnName < ActiveRecord::Migration
  def change
    rename_column :import_logs, :data, :status_import
  end
end

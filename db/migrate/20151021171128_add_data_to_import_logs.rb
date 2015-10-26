class AddDataToImportLogs < ActiveRecord::Migration
  def change
    add_column :import_logs, :data, :string
  end
end

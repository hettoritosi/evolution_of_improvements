class AddTypeToImportLogs < ActiveRecord::Migration
  def change
    add_column :import_logs, :type, :string
  end
end

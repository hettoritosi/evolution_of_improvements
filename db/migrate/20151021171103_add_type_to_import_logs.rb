class AddTypeToImportLogs < ActiveRecord::Migration
  def change
    add_column :import_logs, :type_import, :string
  end
end

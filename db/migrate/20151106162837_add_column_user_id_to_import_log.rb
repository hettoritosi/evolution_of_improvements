class AddColumnUserIdToImportLog < ActiveRecord::Migration
  def change
    add_column :import_logs, :user_id, :integer
  end
end

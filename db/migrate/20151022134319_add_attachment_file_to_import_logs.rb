class AddAttachmentFileToImportLogs < ActiveRecord::Migration
  def self.up
    change_table :import_logs do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :import_logs, :file
  end
end

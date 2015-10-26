class CreateImportLogs < ActiveRecord::Migration
  def change
    create_table :import_logs do |t|


      t.timestamps null: false
    end
  end
end









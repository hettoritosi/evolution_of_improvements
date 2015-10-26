class AddColumnTotalPercentToImprovementLog < ActiveRecord::Migration
  def change
    add_column :import_logs, :total_percent, :integer
  end
end

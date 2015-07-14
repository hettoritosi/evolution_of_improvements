class AddColumnStatusIdToImprovements < ActiveRecord::Migration
  def change
    add_column :improvements, :status_id, :integer
  end
end

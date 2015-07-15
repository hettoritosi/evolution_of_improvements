class AddColumnResponsibleIdToImprovement < ActiveRecord::Migration
  def change
    add_column :improvements, :responsible_id, :integer
  end
end

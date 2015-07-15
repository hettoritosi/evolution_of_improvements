class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :improvements, :category, :string
  end
end

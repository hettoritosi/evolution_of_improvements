class AddPermissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permission, :boolean, default: false
  end
end

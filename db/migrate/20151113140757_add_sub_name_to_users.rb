class AddSubNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sub_name, :string
  end
end

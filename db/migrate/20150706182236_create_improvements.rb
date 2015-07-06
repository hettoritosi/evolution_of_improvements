class CreateImprovements < ActiveRecord::Migration
  def change
    create_table :improvements do |t|
      t.string :title
      t.integer :category
      t.text :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

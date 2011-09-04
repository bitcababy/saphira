class CreateSaphiraFileItems < ActiveRecord::Migration
  def change
    create_table :saphira_file_items do |t|
      t.string :name
      t.string :item_type
      t.string :file_uid
      t.string :file_name
      t.string :slug
      t.string :path
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.text :dynamic_attributes

      t.timestamps
    end
    add_index :saphira_file_items, :slug
    add_index :saphira_file_items, :path, :unique => true
    add_index :saphira_file_items, :parent_id
    add_index :saphira_file_items, :lft
    add_index :saphira_file_items, :rgt
  end
end

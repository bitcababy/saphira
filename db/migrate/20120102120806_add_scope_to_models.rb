class AddScopeToModels < ActiveRecord::Migration
  def change
    add_column :saphira_file_items, :record_scope, :string
    add_column :saphira_image_variants, :record_scope, :string
    add_index :saphira_file_items, :record_scope
    add_index :saphira_image_variants, :record_scope
  end
end

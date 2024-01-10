class AddSourceToStorage < ActiveRecord::Migration[7.0]
  def change
    add_column :manage_storages, :source_id, :integer
    add_column :manage_storages, :source_type, :string
    add_index :manage_storages, [:source_id, :source_type]
  end
end

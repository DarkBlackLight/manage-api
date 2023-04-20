class CreateManageStorages < ActiveRecord::Migration[7.0]
  def change
    create_table :manage_storages do |t|
      t.string :storage_url

      t.timestamps
    end
  end
end

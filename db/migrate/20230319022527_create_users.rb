class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email

      t.string :token
      t.datetime :token_expired_at

      t.string :password_digest

      t.references :source, polymorphic: true

      t.timestamps
    end

    add_index :users, [:source_type, :source_id]
    add_index :users, [:source_type, :email], unique: true, where: "email IS NOT NULL"
    add_index :users, [:source_type, :username], unique: true, where: "username IS NOT NULL"
  end
end

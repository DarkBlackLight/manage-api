class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email

      t.string :token
      t.datetime :token_expired_at

      t.string :password_digest

      t.timestamps
    end

    add_index :users, :email, unique: true, where: "email IS NOT NULL"
    add_index :users, :username, unique: true, where: "username IS NOT NULL"
  end
end

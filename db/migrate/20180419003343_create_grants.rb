class CreateGrants < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
    create_table :grants, id: :uuid do |t|
      t.integer :user_id, null: false
      t.integer :client_id, null: false
      t.datetime :expires_at, null: false
      t.datetime :revoked_at, null: false
      t.string :scopes, null: false, array: true

      t.timestamps
    end
    add_foreign_key :grants, :clients
  end
end

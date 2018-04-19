class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      # Security stuff
      t.string :key, null: false
      t.string :secret, null: false
      t.text :redirect_uri, null: false

      # Client Info
      t.string :name, null: false
      t.text :homepage
      t.text :description
      t.string :logo_id
      t.string :owner_id, null: false

      # Bitfield for permissions
      t.integer :permissions, null: false, default: 0

      # Enum for status
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

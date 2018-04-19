class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens, id: :uuid do |t|
      t.uuid :grant_id, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.string :scope, null: false, array: true, default: []
      t.datetime :expires_at, null: false
      t.datetime :revoked_at

      t.timestamps
    end
    add_foreign_key :tokens, :grants
  end
end

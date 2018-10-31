class SplitGrantsAndTokens < ActiveRecord::Migration[5.2]
  def change
    change_table(:tokens) do |t|
      t.references :user, null: false, index: true
      t.references :client, null: false, index: true
      t.remove_references :grant, null: false, type: :uuid
    end
  end
end

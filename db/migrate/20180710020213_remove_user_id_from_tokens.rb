class RemoveUserIdFromTokens < ActiveRecord::Migration[5.2]
  def change
    remove_column :tokens, :user_id
  end
end

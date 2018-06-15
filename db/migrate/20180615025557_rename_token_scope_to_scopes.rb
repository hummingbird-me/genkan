class RenameTokenScopeToScopes < ActiveRecord::Migration[5.1]
  def change
    rename_column :tokens, :scope, :scopes
  end
end

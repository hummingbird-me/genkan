class AddDefaultToGrantsScopes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :grants, :scopes, []
  end
end

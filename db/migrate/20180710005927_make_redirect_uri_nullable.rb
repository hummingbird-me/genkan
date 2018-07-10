class MakeRedirectUriNullable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :clients, :redirect_uri, true
  end
end

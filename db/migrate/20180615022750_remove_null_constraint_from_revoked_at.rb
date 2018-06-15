class RemoveNullConstraintFromRevokedAt < ActiveRecord::Migration[5.1]
  def change
    change_column_null :grants, :revoked_at, true
  end
end

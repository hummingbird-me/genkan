module Types
  class GrantType < BaseObject
    name 'Grant'

    field :id, ID, null: false
    field :user_id, String, null: false
    field :scopes, [ScopeEnum], null: false
    field :client, ClientType, null: false
  end
end

module Types
  class ClientType < BaseObject
    graphql_name 'Client'

    field :id, ID, null: false
    field :name, String, null: false
    field :homepage, String
    field :description, String
    field :logo_id, String
    field :owner_id, String
  end
end

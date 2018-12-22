# frozen_string_literal: true

module Types
  class ClientType < BaseObject
    graphql_name 'Client'

    field :id, ID, null: false
    field :name, String, null: false
    field :homepage, String, null: true
    field :description, String, null: true
    field :logo_id, String, null: true
    field :owner_id, String, null: true
  end
end

# frozen_string_literal: true

class GenkanSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  scope '/.well-known/', module: 'well_known' do
    get 'jwks.json', to: 'jwks#show', as: 'jwks'
  end

  scope module: 'grants' do
    # Authorization Code Grant (three-legged)
    scope constraints: ResponseTypeConstraint.new('code') do
      get '/authorize', to: 'authorization_code#ask'
      post '/authorize', to: 'authorization_code#grant'
      delete '/authorize', to: 'authorization_code#reject'
    end
    scope constraints: GrantTypeConstraint.new('authorization_code') do
      post '/token', to: 'authorization_code#token'
    end

    # Implicit Grant (two-legged)
    scope constraints: ResponseTypeConstraint.new('token') do
      get '/authorize', to: 'implicit#ask'
      post '/authorize', to: 'implicit#grant'
      delete '/authorize', to: 'implicit#reject'
    end

    # Resource Owner Password Grant
    scope constraints: GrantTypeConstraint.new('password') do
      post '/token', to: 'resource_owner_password#grant'
    end

    # Client Credentials Grant
    scope constraints: GrantTypeConstraint.new('client_credentials') do
      post '/token', to: 'client_credentials#grant'
    end

    # Assertion Grant (RFC 7521)
    scope constraints: GrantTypeConstraint.new('assertion', /\Aurn:ietf:params:oauth:/) do
      post '/token', to: 'assertion#grant'
    end
  end

  root to: 'root#root'
end

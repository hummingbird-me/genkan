require 'jwk'

module WellKnown
  class JWKSController < ApplicationController
    def show
      render json: {
        keys: [JWK.new(Genkan::Application.config.jwt_public_key)]
      }
    end
  end
end

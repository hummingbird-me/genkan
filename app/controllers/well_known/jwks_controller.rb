# frozen_string_literal: true

module WellKnown
  class JWKSController < ApplicationController
    def show
      key = JSON::JWK.new(Genkan::Application.config.jwt_public_key)
      set = JSON::JWK::Set.new(key)
      render json: set
    end
  end
end

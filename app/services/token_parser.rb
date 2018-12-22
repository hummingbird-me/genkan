# frozen_string_literal: true

require_dependency 'url_helpers'

module TokenParser
  class << self
    def parse(str)
      JWT.decode(str, public_key, algorithm: algorithm)
    end

    def dump(payload)
      payload = { jku: UrlHelpers.jwks_url }.merge(payload)
      JWT.encode(payload, private_key, algorithm)
    end

    private

    def algorithm
      @algorithm ||= Genkan::Application.config.jwt_algorithm
    end

    def private_key
      @private_key ||= Genkan::Application.config.jwt_private_key
    end

    def public_key
      @public_key ||= Genkan::Application.config.jwt_public_key
    end
  end
end

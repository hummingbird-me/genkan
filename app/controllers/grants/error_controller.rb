# frozen_string_literal: true

module Grants
  class ErrorController < ApplicationController
    def unsupported_response_type
      raise OAuth2Error::UnsupportedResponseType
    end
  end
end

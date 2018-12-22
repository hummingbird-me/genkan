# frozen_string_literal: true

module UrlHelpers
  class << self
    include Rails.application.routes.url_helpers

    def url_options
      super.merge(Thread.current[:url_options] || {})
    end
  end
end

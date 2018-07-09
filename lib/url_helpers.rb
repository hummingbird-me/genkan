module UrlHelpers
  module_function

  include Rails.application.routes.url_helpers

  def url_options
    super.merge(host: Thread.current[:request_host])
  end
end

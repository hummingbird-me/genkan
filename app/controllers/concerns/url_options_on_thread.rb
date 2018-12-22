# frozen_string_literal: true

require_dependency 'with_thread_variable'

# Adds the url options to the thread during the request lifecycle
module UrlOptionsOnThread
  extend ActiveSupport::Concern
  include WithThreadVariable

  included do
    around_action :_url_options_on_thread
  end

  def _url_options_on_thread(&block)
    with_thread_variable(url_options: url_options, &block)
  end
end

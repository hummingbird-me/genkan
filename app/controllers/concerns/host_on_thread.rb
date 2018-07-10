require_dependency 'with_thread_variable'

# Adds the request host to the thread during the request lifecycle
module HostOnThread
  extend ActiveSupport::Concern
  include WithThreadVariable

  included do
    around_action :_host_on_thread
  end

  def _host_on_thread(&block)
    with_thread_variable(request_host: request.host_with_port, &block)
  end
end

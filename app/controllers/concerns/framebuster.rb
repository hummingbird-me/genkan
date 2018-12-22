# frozen_string_literal: true

# Prevent clickjacking via headers.  This covers all our supported browsers: we do not need a
# JavaScript framebuster.
#
# To disable this on a specific action, you can use `skip_before_action :framebuster, on: [:foo]`
module Framebuster
  extend ActiveSupport::Concern

  included do
    before_action :framebuster
  end

  def framebuster
    response.headers['X-Frame-Options'] = 'DENY'
    response.headers['Content-Security-Policy'] = "frame-ancestors 'none'"
  end
end

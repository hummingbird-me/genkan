module CookieAuthentication
  extend ActiveSupport::Concern

  def token
    TokenVerifier.new(cookies[:token]).token
  end

  def user_id
    token['sub'] if token
  end
end

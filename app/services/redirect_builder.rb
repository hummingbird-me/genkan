# frozen_string_literal: true

# Given a URI and a Kind (fragment or query), makes adding params easy.
class RedirectBuilder
  # @param uri [String] the redirect URI to work with
  # @param kind [:fragment,:query] where to place the parameters
  def initialize(uri, kind)
    @uri = Addressable::URI.parse(uri)
    @kind = kind
  end

  # @param params [Hash] the parameters to send in the redirect
  # @return [String] the URI to redirect to
  def uri_for(params)
    params = uri_params.merge(params)
    query = Addressable::URI.form_encode(params)
    @uri.merge(@kind => query).to_s.sub('=&', '&')
  end

  private

  def uri_params
    params = @uri.public_send(@kind)

    if params.present?
      Addressable::URI.form_unencode(params).to_h
    else
      {}
    end
  end
end

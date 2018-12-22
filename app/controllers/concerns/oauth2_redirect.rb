module OAuth2Redirect
  extend ActiveSupport::Concern

  def redirect_uri
    redirect_uri = params[:redirect_uri]

    raise InvalidRedirect unless client.valid_redirect_uri?(redirect_uri)

    redirect_uri
  end

  def redirect_with(params)
    params = { stat: params[:state] }.merge(params).compact

    uri = RedirectBuilder.new(redirect_uri, redirect_type).uri_for(params)
    redirect_to(uri, status: 302)
  end

  def redirect_type
    case params[:response_type]
    when 'token' then :fragment
    when 'code' then :query
    end
  end
end

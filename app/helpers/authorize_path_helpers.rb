# frozen_string_literal: true

require_dependency 'url_helpers'

module AuthorizePathHelpers
  SAVED_PARAMS = %i[response_type client_id redirect_uri scope state].freeze

  def authorize_path(*args, **kvargs)
    saved_params = params.slice(*SAVED_PARAMS).permit!

    kvargs[:params] = (kvargs[:params] || {}).merge(saved_params)
    UrlHelpers.authorize_path(*args, **kvargs)
  end
end

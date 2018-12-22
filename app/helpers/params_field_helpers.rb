module ParamsFieldHelpers
  include ActionView::Helpers::FormTagHelper

  PARAMS_FIELDS = %i[response_type client_id redirect_uri scope state].freeze

  def params_fields
    # This uses Array#inject(:+) because Array#join isn't SafeBuffer-aware
    PARAMS_FIELDS.map { |key|
      hidden_field_tag key, params[key] if params[key]
    }.inject(:+)
  end
end

# frozen_string_literal: true

class ResponseTypeConstraint
  def initialize(*response_types)
    @response_types = response_types
  end

  def matches?(request)
    @response_types.any? { |type| type === request.query_parameters[:response_type] }
  end
end

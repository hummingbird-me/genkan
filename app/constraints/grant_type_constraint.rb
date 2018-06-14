class GrantTypeConstraint
  def initialize(*grant_types)
    @grant_types = grant_types
  end

  def matches?(request)
    @grant_types.any? { |type| type === request.request_parameters[:grant_type] }
  end
end

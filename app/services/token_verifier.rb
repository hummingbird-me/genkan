class TokenVerifier
  # @param token [String] the JWT token to verify
  def initialize(token)
    @token = TokenParser.parse(token)[0]
  rescue JWT::DecodeError
    @token = nil
    @valid = false
  end

  # @return [Boolean] whether the token is valid or not
  def valid?
    return @valid unless @valid.nil?
    !Token.find(@token['jti']).revoked?
  end

  # @return [Hash,nil] the token data if valid, otherwise nil
  def token
    @token if valid?
  end
end

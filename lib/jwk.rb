# Wraps an OpenSSL::PKey into a form that can be serialized as a JWK.
# TODO: add full RSA support
class JWK
  def initialize(key)
    unless key.is_a?(OpenSSL::PKey::RSA) || key.is_a?(OpenSSL::PKey::EC)
      raise ArgumentError, 'key must be an RSA or EC key'
    end
    @key = key
  end

  def as_json(*args)
    to_h.as_json(*args)
  end

  def to_h
    %i[alg kty crv x y alg].map { |k| [k, send(k)] }.to_h
  end

  private

  def alg
    case @key
    when OpenSSL::PKey::EC
      case @key.group.degree
      when 521 then 'ES512'
      else "ES#{@key.group.degree}"
      end
    end
  end

  # @return [String] the key type, either 'RSA' or 'EC'
  def kty
    @key.class.name.demodulize
  end

  # @return [String] the curve name
  def crv
    "P-#{@key.group.degree}"
  end

  # @return [String] the base64-encoded X coordinate
  def x
    Base64.urlsafe_encode64(coordinates.slice(1, 32), padding: false)
  end

  # @return [String] the base64-encoded Y coordinate
  def y
    Base64.urlsafe_encode64(coordinates.slice(33, 32), padding: false)
  end

  def coordinates
    @coordinates ||= @key.public_key.to_octet_string(:uncompressed)
  end
end

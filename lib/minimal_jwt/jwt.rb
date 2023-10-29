require 'base64'
require 'json'
require 'openssl'

class JWT
  attr_accessor :token

  def initialize(token:)
    @token = token
    header, payload, signature = @token.split('.')
    @header = header
    @payload = payload
    @signature = signature
  end

  def valid?
    return false if @token.nil?
    return false if @header.nil? || @payload.nil? || @signature.nil?

    begin
      base64_decode(@header)
      base64_decode(@payload)
      base64_decode(@signature)
      true
    rescue StandardError
      false
    end
  end

  def header
    raise InvalidJwtError unless valid?

    JSON.parse(base64_decode(@header))
  end

  def payload
    raise InvalidJwtError unless valid?

    JSON.parse(base64_decode(@payload))
  end

  def signature_verified?
    return false unless valid?

    data_to_verify = "#{@header}.#{@payload}"
    calculated_encoded_signature = base64_encode(signature(Algorithm::HS256, secret, data_to_verify))
    calculated_encoded_signature == @signature
  end

  def self.encode(algorithm: Algorithm::HS256, payload:)
    raise InvalidPayloadError.new('Payload should be a hash') unless payload.is_a?(Hash)

    header = {
      alg: algorithm,
      typ: :JWT
    }
    encoded_header = base64_encode(header.to_json)
    encoded_payload = base64_encode(payload.to_json)
    data_to_sign = "#{encoded_header}.#{encoded_payload}"

    encoded_signature = base64_encode(signature(algorithm, secret, data_to_sign))

    JWT.new(token: "#{data_to_sign}.#{encoded_signature}")
  end

  private

  def self.signature(algorithm, secret, data_to_sign)
    case algorithm
    when Algorithm::HS256
      OpenSSL::HMAC.digest('sha256', secret, data_to_sign)
    else
      raise UnsupportedSigningAlgorithmError.new("Sorry! Signing with #{algorithm.to_s} is not supported yet")
    end
  end

  def self.base64_encode(content)
    Base64.urlsafe_encode64(content).tr('=', '')
  end

  def self.secret
    ENV['MINIMAL_JWT_SIGNATURE_SECRET'] || ''
  end

  def signature(algorithm, secret, data_to_sign)
    self.class.signature(algorithm, secret, data_to_sign)
  end

  def base64_encode(content)
    self.class.base64_encode(content)
  end

  def secret
    self.class.secret
  end

  def base64_decode(content)
    Base64.urlsafe_decode64(content).tr('=', '')
  end
end

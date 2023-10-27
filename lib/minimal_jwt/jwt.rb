require 'base64'
require 'json'

class Jwt
  def self.decode(jwt)
    _, payload, _ = jwt.split('.')
    decoded_payload = Base64.urlsafe_decode64(payload)
    JSON.parse(decoded_payload).transform_keys(&:to_sym)
  end
end

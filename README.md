# minimal_jwt

A lightweight library for encoding & decoding JSON Web Tokens (JWTs).


## Installation
- Set the HMAC algorithm signing secret as the environment variable `MINIMAL_JWT_SIGNATURE_SECRET`. If environment 
variable is not set, an empty string would be used as the signing secret.
- Include the dependency by either adding `gem 'minimal_jwt'` in your `Gemfile` or run `gem install minimal_jwt` in your
terminal in the directory of your codebase.
- Require the library by adding `require 'minimal_jwt'` wherever the library needs to be utilized.

## Usage
### Encoding
Use
```
JWT.encode(payload: your_payload_json)
```
to encode your payload JSON

### Decoding
You can instantiate a JWT object with any token. There are methods exposed on the object, such as:
- `valid?` - tells you if the token is a well-formed JWT or not
- `header` - returns the header component of the JWT as a hash
- `payload` - returns the payload component of the JWT as a hash
- `signature_verified?` - tells you if the signature component of the token can be verified or not using the signing 
secret

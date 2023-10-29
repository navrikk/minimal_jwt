require 'rspec'
require 'minimal_jwt'
include MinimalJwt

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

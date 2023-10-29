require_relative "lib/minimal_jwt/version"

Gem::Specification.new do |spec|
  spec.name = 'minimal_jwt'
  spec.version = MinimalJwt::VERSION
  spec.platform = Gem::Platform::RUBY

  spec.authors = 'Nikshep A V'
  spec.email = 'nikshep.av@gmail.com'

  spec.summary = 'Minimal JWT'
  spec.description = 'A minimal lightweight JWT library'

  spec.required_ruby_version = '>= 3.0.0'

  spec.executables = spec.files.grep(%r{^bin/}) { |file| File.basename(file) }
  spec.files = Dir['lib/**/*.rb'] + ['README.md']
  spec.require_paths = ['lib']

  spec.metadata["source_code_uri"] = "https://github.com/navrikk/minimal_jwt"
end

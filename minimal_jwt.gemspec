Gem::Specification.new do |spec|
  spec.name = 'minimal_jwt'
  spec.version = '1.0.0'
  spec.date = '2023-10-27'
  spec.summary = 'Minimal JWT'
  spec.description = 'A minimal lightweight JWT library'
  spec.authors = 'Nikshep A V'
  spec.email = 'nikshep.av@gmail.com'
  spec.executables = spec.files.grep(%r{^bin/}) { |file| File.basename(file) }
  spec.require_paths = ['lib']
  spec.license = 'MIT'
  spec.files = %w[lib/minimal_jwt.rb lib/minimal_jwt/jwt.rb]
  spec.required_ruby_version = '>= 2.5.0'
end

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
  spec.files = Dir['lib/**/*.rb'] + ['README.md']
  spec.required_ruby_version = '>= 3.1.2'
end

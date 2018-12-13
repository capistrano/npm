# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-npm'
  spec.version       = '1.0.3'
  spec.authors       = ['Scott Walkinshaw']
  spec.email         = ['scott.walkinshaw@gmail.com']
  spec.description   = %q{npm support for Capistrano 3.x}
  spec.summary       = %q{npm support for Capistrano 3.x}
  spec.homepage      = 'https://github.com/capistrano/npm'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '>= 3.0.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end

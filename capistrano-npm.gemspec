# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capistrano/npm/version'

Gem::Specification.new do |s|
  s.name          = 'capistrano-npm'
  s.version       = Capistrano::Npm::VERSION
  s.authors       = ['Scott Walkinshaw']
  s.email         = ['scott.walkinshaw@gmail.com']
  s.homepage      = 'https://github.com/swalkinshaw/capistrano-npm'
  s.summary       = %q{Capistrano extension for npm (Node Packaged Modules)}
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.require_paths = %w(lib)

  s.add_dependency 'capistrano', '>= 2.5.5'
end

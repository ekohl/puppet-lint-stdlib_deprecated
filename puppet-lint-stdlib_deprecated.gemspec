# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-stdlib_deprecated'
  spec.version     = '0.1.0'
  spec.homepage    = "https://github.com/ekohl/#{spec.name}"
  spec.license     = 'MIT'
  spec.author      = ['Ewoud Kohl van Wijngaarden']
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.summary     = 'A puppet-lint plugin to check for deprecated stdlib usage'
  spec.description = <<~DESC
    Stdlib is a very commonly used module and breaking changes are painful.
    This puppet-lint plugin detects and corrects some deprecated usage.
  DESC

  spec.required_ruby_version = '>= 2.7', '< 4'

  spec.add_dependency 'puppet-lint', '>= 3', '< 5'
end

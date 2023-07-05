# frozen_string_literal: true

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gemspec

gem 'rake', '~> 13.0'

group :rubocop do
  gem 'voxpupuli-rubocop', '~> 1.1', require: false
end

group :development do
  gem 'rspec', '~> 3.12', require: false
  gem 'rspec-collection_matchers', '~> 1.2', require: false
  gem 'rspec-its', '~> 1.3', require: false
end

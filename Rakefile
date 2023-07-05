# frozen_string_literal: true

begin
  require 'rspec/core/rake_task'
rescue LoadError
  # rspec in in an optional group
else
  RSpec::Core::RakeTask.new(:spec)
end

begin
  require 'rubocop/rake_task'
rescue LoadError
  # RuboCop is an optional group
else
  RuboCop::RakeTask.new(:rubocop) do |task|
    # These make the rubocop experience maybe slightly less terrible
    task.options = ['--display-cop-names', '--display-style-guide', '--extra-details']

    # Use Rubocop's Github Actions formatter if possible
    task.formatters << 'github' if ENV['GITHUB_ACTIONS'] == 'true'
  end
end

default_deps = []
default_deps << :rubocop if Rake::Task.task_defined?(:rubocop)
default_deps << :spec if Rake::Task.task_defined?(:spec)

task default: default_deps if default_deps.any?

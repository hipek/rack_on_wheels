require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Run rubocop'
task :rubocop do
  system 'rubocop spec lib'
end

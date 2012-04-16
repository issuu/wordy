require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "wordy-ruby"
  gem.homepage = "http://github.com/bastien/wordy"
  gem.license = "MIT"
  gem.summary = "Wordy API"
  gem.description = "Ruby library to access the Wordy API"
  gem.email = "bastien.vaucher@gmail.com"
  gem.authors = ["Bastien Vaucher - MagmaHQ"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  gem.add_development_dependency 'rspec', '>= 2.9.0'
  gem.add_dependency "activesupport", '>= 3.2.2'
end
Jeweler::RubygemsDotOrgTasks.new


require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec
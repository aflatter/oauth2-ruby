$LOAD_PATH.unshift(File.expand_path(File.join('..', '..', 'oauth2-core', 'lib'),
                                    File.dirname(__FILE__)))

require "rubygems"

begin
  require "bundler"
  Bundler.setup
rescue LoadError => e
  puts 'Bundler not found. Please install bundler with the command gem install bundler'
end

begin
  require 'rspec'
  require 'rspec/autorun'
rescue LoadError => e
  puts 'RSpec not found. Please install rspec with command bundle install'
end

require 'oauth2/server'

Rspec.configure do |config|
  config.debug = true
  config.mock_with :rspec
  #config.fixture_path = File.join File.dirname(__FILE__), 'fixtures'
end

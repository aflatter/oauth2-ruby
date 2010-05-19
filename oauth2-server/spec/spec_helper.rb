$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'oauth2-core', 'lib'))

require "rubygems"
require "bundler"
Bundler.setup

require 'oauth2/server'
require 'rspec'
require 'rspec/autorun'

Dir.glob(File.dirname(__FILE__) + "/support/**/*.rb").each do |file|
  require file
end

Rspec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  # config.mock_with :rspec
  
  config.include OAuth2::Matchers
end
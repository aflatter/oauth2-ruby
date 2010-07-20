require 'oauth2/core'
require 'active_model'
require 'active_support'
require 'oauth2/models'
require 'oauth2/validators'

module OAuth2

  module Server
    DEFAULT_CONFIG = { :orm => :ActiveRecord,
                       :database => { :adapter  => 'mysql',
                                      :database => 'oauth2-server-test',
                                      :username => 'oauth2_tester',
                                      :password => 'tester123',
                                      :host     => 'localhost' } }

    def self.configurations
      DEFAULT_CONFIG
    end

    autoload :Request,        'oauth2/server/request'
    autoload :Requests,       'oauth2/server/requests'
  end

end

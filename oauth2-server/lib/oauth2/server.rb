require 'oauth2/core'
require 'active_model'
require 'active_support'
require 'oauth2/validators'

module OAuth2

  autoload :Models,     'oauth2/models'
  autoload :Factories,  'oauth2/factories'

  module Server
    DEFAULT_CONFIG = { :orm => :ActiveRecord,
                       :database => { :adapter  => 'mysql',
                                      :database => 'oauth2-server-test',
                                      :username => 'oauth2_tester',
                                      :password => 'tester123',
                                      :host     => 'localhost' },
                       :models => { :client_application => 'oauth2_client_applications' } }

    def self.configurations
      DEFAULT_CONFIG
    end

    autoload :Request,        'oauth2/server/request'
    autoload :Requests,       'oauth2/server/requests'
  end

end

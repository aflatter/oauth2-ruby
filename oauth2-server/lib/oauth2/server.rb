require 'oauth2/core'
require 'active_model'
require 'active_support'

module OAuth2

  module Server
    autoload :Request,  'oauth2/server/request'
    autoload :Requests, 'oauth2/server/requests'
  end

end

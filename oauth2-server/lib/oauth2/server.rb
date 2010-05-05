require 'oauth2/core'

module OAuth2
  
  module Server
    autoload :Flows,      'oauth2/server/flows'
    autoload :Rails,      'oauth2/server/rails'
    autoload :Request,    'oauth2/server/request'
  end
  
end
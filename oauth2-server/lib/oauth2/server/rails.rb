require 'oauth2/callbacks'
require 'oauth2/server/request'

module OAuth2
  
  module Server
    
    module Rails
      
      # class UsersController < ApplicationController
      #   include OAuth2::Server::Rails::ProtectedController
      #
      #   def oauth2_realm
      #     'example.com'
      #   end
      # end
      module ProtectedController
        
        extend ActiveSupport::Concern

        included do
          include OAuth2::Callbacks
        end
        
        protected

        def oauth2_request_uri
          request.fullpath
        end

        def oauth2_algorithms
          'hmac-sha256'
        end

        def oauth2_request_header
          request.authorization
        end

        def oauth2_host_with_port
          # FIXME: This is wrong
          request.headers['Host']
        end

        def oauth2_verify_request
          oauth2_request = Request.validate(:context => self)
          oauth2_invalid_request unless oauth2_request.valid?
        end
        
        def oauth2_invalid_request(request)
          # FIXME: Error is incorrect
          header = OAuth2::Headers::Authenticate.new(
            :realm      => oauth2_realm,
            :algorithms => oauth2_algorithms,
            :error      => 'invalid_signature'
          )
          response.headers['WWW-Authenticate'] = header
          # FIXME: Render errors in response
          head :status => :unauthorized
        end
        
      end
      
    end
    
  end
  
end
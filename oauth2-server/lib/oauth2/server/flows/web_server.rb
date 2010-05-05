require 'oauth2/attributes'

module OAuth2
  
  module Server
    
    module Flows
      
      class WebServer
        
        include OAuth2::Attributes
        
        def create_ticket(&block)
          if block_given?
            callbacks[:create_ticket] = block
          else
            block.call
          end
        end
        
        attributes  :create_ticket,
                    :verify_resource_owner,
                    :render_authorize_form
        
        # This method will create a ticket for the client and try to identify
        # and verify the resource owner.
        # If those two steps succeed, it displays the authorization form.
        def request_authorization
          create_ticket
          verify_resource_owner or return
          render_authorize_form
        end
        
        attributes  :create_verification_code,
                    :authorized?
                    :redirect_back

        # If the user authorized the client, we create a verification code.
        # Then we redirect back with the verification code or an error message.
        def grant_authorization
          create_verification_code if authorized?
          redirect_back
        end

        # TODO
        def access_token
          # TODO: verify that type == "web_sever"
          # TODO: verify that redirect_uri == ticket.redirect_uri
        end
        
      end
      
    end
    
  end
  
end
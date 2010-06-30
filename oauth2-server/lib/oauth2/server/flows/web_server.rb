require 'oauth2/attributes'

module OAuth2

  module Server

    module Flows

      #
      # = Attributes
      #
      # == verify_resource_owner
      #   If the resource owner is logged in, we can proceed. If he's not, start
      #   the login procedure. Basic example:
      #   <code>
      #   def verify_resource_owner
      #      redirect_to login_path unless logged_in?
      #   end
      #   </code>
      #   FIXME: This example does not save the oauth2 query parameters which are
      #          needed after a user has just logged in.
      #
      # == authorize
      #   Asks the user if he wants to authorize the client. Usually, this would
      #   show some kind of form which calls #grant_authorization on submission.
      #   <code>
      #   def authorize
      #     render 'authorize'
      #   end
      #   </code>
      #   <code>
      #   <form action="/oauth2/grant_authorization" method="post">
      #     <input type="hidden" name="mode" value="flow_web_server" />
      #     <input type="hidden" name="oauth_client_identifier" value="<%= params[:oauth_client_identifier]" />
      #     <input type="hidden" name="oauth_callback_url" value = "<%= params[:oauth_callback_url]" />
      #     <input type="submit" name="submit" value="Allow" />
      #     <input type="submit" name="submit" value="Deny" />
      #  </form>
      class WebServer

        include OAuth2::Attributes

        attributes  :verify_resource_owner,
          :render_authorize_form

        # This method try to identify and verify the resource owner.
        # It displays the authorization form on success.
        def request_authorization
          assert_equal params[:mode], 'flow_web_server'

          verify_resource_owner or return
          authorize
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

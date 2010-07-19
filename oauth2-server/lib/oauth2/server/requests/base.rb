module OAuth2
  module Server
    module Requests

      # +OAuth2::Server::Requests::Base+ is an abstract request class that implements the generic behavior of
      # the requests described and defined in OAuth2 draft 09.
      #
      # For more information about the different requests available in OAuth2, please reffer to the official
      # specification: http://tools.ietf.org/html/draft-ietf-oauth-v2-09
      class Base
        # Included behavior
        include ActiveModel::Validations

        # Accessors
        attr_accessor :http_request, :client

        # Constructor
        def initialize(values = { :http_request => OAuth2::Server::Request.new })
          raise ArgumentError unless values.is_a? Hash

          self.http_request = values[:http_request]
        end
      end

    end
  end
end

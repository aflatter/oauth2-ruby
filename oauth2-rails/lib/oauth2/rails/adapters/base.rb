module OAuth2

  module Rails

    module Adapters

      class Base

        def initialize(options)
          @options = options
        end

        # Must be implemented by subclasses
        # Returns true on success, else false.
        def create_authorization_code_grant(attributes)
          raise NotImplementedError.new
        end

      end

    end

  end

end
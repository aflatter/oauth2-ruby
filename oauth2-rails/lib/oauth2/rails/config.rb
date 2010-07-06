require 'active_support/core_ext/module'

module OAuth2

  module Rails

    class Config
      
      class << self
        # We alias this method to something shorter.
        alias :option :attr_accessor_with_default
      end
      
      option :adapter, :active_record

      option :enforce_scopes, true

      option :models, {
        :client => :client
      }

      def setup(&block)
        yield self if block_given?
      end

    end

  end

end
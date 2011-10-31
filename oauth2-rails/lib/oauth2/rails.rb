require 'oauth2/rails/engine' if defined?(Rails)
require 'oauth2/rails/config'
require 'active_support/core_ext/module'

module OAuth2

  module Rails

    class << self

      mattr_accessor :config
      self.config = Config.new

      def setup(&block)
        config.setup(&block)
      end

    end

  end

end
require 'rails'

module OAuth2

  module Rails

    class Engine < ::Rails::Engine

      class << self

        def root
          @root ||= File.expand_path("../../../..", __FILE__)
        end

      end

      generators do
        pattern = File.join(root, "generators", "oauth2", "*_generator.rb")
        Dir.glob(pattern).each { |f| require f }
      end

      %w{models controllers}.each do |dir|
        path = File.join(root, 'app', dir)
        config.load_paths << path
        config.load_once_paths.delete(path)
      end

    end

  end

end
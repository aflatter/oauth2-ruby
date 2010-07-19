module OAuth2
  module Server

    # +Request+ is the gem level representation of the HTTP Request received by your application.
    #
    # OAuth2-Rails translates ActionDispatch::Request into OAuth2::Server::Request
    class Request
      # Included behavior
      include ActiveModel::Validations

      # Accessors
      attr_accessor :http_method, :http_content_type, :params

      # Validations
      validates :http_method, :http_method => { :method => [:get, :post] }
      validates :http_content_type, :http_content_type => true
      validates :params, :params => true

      # Constructor
      def initialize(values = {})
        raise ArgumentError unless values.is_a? Hash

        values.each do |k,v|
          attribute_writter = "#{k}="
          self.send(attribute_writter, v) if self.respond_to?(attribute_writter)
        end
      end
    end

  end
end

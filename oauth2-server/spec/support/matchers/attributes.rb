module OAuth2
  module Matchers
    
    class Attributes #:nodoc:
      def initialize(*names)
        @names = names
        @missing_names = []
      end
      
      def matches?(actual)
        @actual = actual
        @names.each do |name|
          @missing_names << name unless actual.attribute_names.include?(name)
        end
        return @missing_names.empty?
      end
      
      def failure_message_for_should
        "expected #{@actual.inspect} to have attributes " +
        "#{@missing_names.collect {|name| name.inspect }.join(', ')}"
      end
      
      def failure_message_for_should_not
        "expected #{@actual.inspect} not to have attributes " + 
        "#{@names.collect {|name| name.inspect }.join(', ')}"
      end
      
      def description
        "have oauth2 attributes #{@names.inspect}"
      end
      
      def argument
        self
      end

      alias :arguments :argument
    end
    
    # :call-seq:
    #   should haveoauth2_attribute_names(*names)
    #   should_not haveoauth2_attribute_names(*names)
    #
    # Matches if the target object has all of the
    # attributes provided.
    #
    # == Examples
    #     
    def have_attributes(*names)
      Matchers::Attributes.new(*names)
    end
    
    alias :have_attribute :have_attributes
  end
end

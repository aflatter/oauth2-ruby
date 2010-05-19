require 'spec_helper'

describe OAuth2::Server::Request do
  
  describe "class" do

    subject { OAuth2::Server::Request }

    it "instantiates a request, then validates and returns it" do
      attributes = {:foo => :bar}
      request = subject.new(attributes)

      subject.should_receive(:new).with(attributes).
                              once.and_return(request)
      request.should_receive(:validate).with(no_args).once.and_return(true)
    
      subject.validate(attributes).should == request
    end
    
    it "#initialize takes a block and yields itself" do
      called = false

      subject.new(:realm => "foo") do |req|
        called = true
        req.realm.should == "foo"
      end

      called.should be_true
    end
    
  end
  
  subject { OAuth2::Server::Request.new }
  
  it { should have_attribute(:request_uri) }
  it { should have_attribute(:host_with_port) }
  it { should have_attribute(:realm) }
  it { should have_attribute(:algorithms) }
  it { should have_attribute(:request_header) }

  it { should respond_to(:errors) }
  
  it "overwrites #request_header to automatically parse strings" do
    subject.request_header = 'foo'
  
    OAuth2::Headers::Authorization.should_receive(:parse).with('foo').and_return("bar")
    subject.request_header.should == "bar"
  end
  
  it "overwritten #request_header behaves like the original method" do
    block = lambda { :foo }
    subject.request_header(&block).should == nil
    subject.attributes[:request_header].should == block
    subject.request_header.should == :foo
  end

  # @fixme: This example cries.
  it "calculates signature" do
    header = stub("Authorization header")
  
    [:timestamp, :nonce, :algorithm].each do |attribute|
      header.should_receive(attribute).once.with(no_args).and_return(attribute.to_s)
    end
  
    normalized_string = [
      :timestamp, :nonce, :algorithm, "GET",
      "server.example.com:80", "http://example.com/resource"
    ].join(',')

    subject.should_receive(:host_with_port).once.and_return("server.example.com:80")
    subject.should_receive(:request_uri).once.and_return("http://example.com/resource")
    subject.should_receive(:method).once.with(no_args).and_return("get")
    subject.should_receive(:request_header).exactly(3).times.with(no_args).and_return(header)
    subject.should_receive(:secret).once.and_return("secret")

    HMAC::SHA256.should_receive(:digest).once.
                 with("secret", normalized_string).
                 and_return("digest")
  
    ActiveSupport::Base64.should_receive(:encode64s).
                          with("digest").
                          and_return("signature")

    subject.calculate_signature.should == "signature"
  end

  it "re-calculates and then validates the request signature" do
    header = stub("Authorization header")
    header.should_receive(:signature).once.with(no_args).and_return("signed")
    subject.should_receive(:calculate_signature).once.with(no_args).and_return("signed")
    subject.should_receive(:request_header).once.with(no_args).and_return(header)
    subject.validate_signature.should be_true
  end

  it "sets request type" do
    header = OAuth2::Headers::Authorization.new

    subject.request_header = header
    
    header.token        = 'foo'
    subject.type.should == :bearer
  
    %w{nonce timestamp algorithm}.each do |attribute|
      header.send("#{attribute}=".to_sym, attribute)
    end
    subject.type.should == :unknown
  
    header.signature    = "signature"
    subject.type.should == :cryptographic
  end
  
  it "works on a real world cryptographic example" do
    subject.request_header = <<-EOS
      Token token="vF9dft4qmT", 
            nonce="s8djwd",
            timestamp="137131200",
            algorithm="hmac-sha256",
            signature="ZSPk4B37TjHu3/yyu31LD7/agpzPjhYQEszZk7GdEfs="
            EOS
    subject.realm           = "my little farm"
    subject.algorithms      = 'hmac-sha256'
    subject.access_token    = "my_token"
    subject.secret          = "secret"
    subject.method          = "GET"
    subject.host_with_port  = "example.com:80"
    subject.request_uri     = "http://example.com/protected"
    subject.access_token_expired? { false }
    subject.validate.should be_true
  end
  
  it "works on a real world bearer example" do
    subject.request_header = 'Token token="vF9dft4qmT"'
    subject.realm           = "my little farm"
    subject.algorithms      = 'hmac-sha256'
    subject.access_token    = 'vF9dft4qmT'
    subject.access_token_expired? { false }
    subject.validate.should be_true
  end
end
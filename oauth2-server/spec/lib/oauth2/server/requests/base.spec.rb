require 'spec_helper.rb'

# rename the file from base.spec.rb to base_spec.rb in order to re-activate these testes
describe OAuth2::Server::Requests::Base do
  describe "constructor" do
    it "has a constructor that doesn't require any params" do
      lambda { OAuth2::Server::Requests::Base.new }.should_not raise_error(Exception)
    end

    it "accepts a request object" do
      lambda { OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new) }.should_not raise_error(ArgumentError)
    end

    it "rejects all other parameter types" do
      lambda { OAuth2::Server::Requests::Base.new("OAuth2 rocks!") }.should raise_error(ArgumentError)
    end

    it "knows how to set its attributes based on the request object" do
      # TODO: pass a mock object
      req = OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new)
      req.client.should_not be_nil
      req.http_method.should == :get
      req.http_content_type.should == 'application/x-www-form-urlencoded'
    end
  end

  describe "validations" do
    it "implements the valid method" do
      subject.should respond_to(:valid?)
    end

    describe "http method" do
      it "accepts valid get requests" do
        # TODO: Pass in a valid GET request
        OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should be_valid
      end

      it "accepts valid post request" do
        # TODO: Pass in a valid POST request
        OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should be_valid
      end

      it "rejects valid requests that are not get or post" do
        # TODO: Pass in a valid DELETE request
        OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should_not be_valid
      end
    end
    
    describe "http content type" do
      it "accepts application/x-www-form-urlencoded as a content type" do
        # TODO: Pass in a valid application/x-www-form-urlencoded request
        OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should be_valid
      end
      
      it "rejects all others" do
        # TODO: Pass in a valid application/json request
        OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should_not be_valid
      end
    end
  end

  describe "process" do
    it "implements the process method" do
      subject.should respond_to(:process)
    end

    it "knows if it has already been processed" do
      subject.processed?.should be_false
    end

    it "raises a NotImplementedError when executing process on the base request class" do
      lambda { subject.process }.should raise_error(NotImplementedError)
    end
  end
end

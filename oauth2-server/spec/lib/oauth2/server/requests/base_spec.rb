require 'spec_helper.rb'

describe OAuth2::Server::Requests::Base do
  describe "constructor" do
    it "has a constructor that doesn't require any params" do
      lambda { OAuth2::Server::Requests::Base.new }.should_not raise_error(Exception)
    end

    it "accepts a values hash" do
      Requests = OAuth2::Server::Requests
      lambda { Requests::Base.new({ :request => OAuth2::Server::Request.new }) }.should_not raise_error(ArgumentError)
    end

    it "rejects all other parameter types" do
      lambda { OAuth2::Server::Requests::Base.new("OAuth2 rocks!") }.should raise_error(ArgumentError)
    end

    it "sets the request attribute to the provided value" do
      request = OAuth2::Server::Request.new({ :http_content_type => 'application/x-www-form-urlencoded',
                                              :http_method => :get,
                                              :params => {} })

      base_request = OAuth2::Server::Requests::Base.new({ :http_request => request })
      base_request.http_request.should == request
    end
  end # Constructor

  describe "http request parsing" do
    before :each do
      request = OAuth2::Server::Request.new({ :http_content_type => 'application/x-www-form-urlencoded',
                                              :http_method => :get,
                                              :params => { :client_id => 'gnomeslab' } })

      @base = base_request = OAuth2::Server::Requests::Base.new({ :http_request => request })
    end

    it "sets the client based on request.params client_id" do
      pending
      # client = mock('Client')
      # client.stub! :id => 1, :external_id => 'gnomeslab'
      #
      # puts client.inspect
      #@base.client.should == Client.find_by_external_id('gnomeslab')
    end
  end # request parsing
  #
  # describe "validations" do
  #   it "implements the valid method" do
  #     subject.should respond_to(:valid?)
  #   end
  #
  #   describe "http method" do
  #     it "accepts valid get requests" do
  #       # TODO: Pass in a valid GET request
  #       OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should be_valid
  #     end
  #
  #     it "accepts valid post request" do
  #       # TODO: Pass in a valid POST request
  #       OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should be_valid
  #     end
  #
  #     it "rejects valid requests that are not get or post" do
  #       # TODO: Pass in a valid DELETE request
  #       OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should_not be_valid
  #     end
  #   end
  #
  #   describe "http content type" do
  #     it "accepts application/x-www-form-urlencoded as a content type" do
  #       # TODO: Pass in a valid application/x-www-form-urlencoded request
  #       OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should be_valid
  #     end
  #
  #     it "rejects all others" do
  #       # TODO: Pass in a valid application/json request
  #       OAuth2::Server::Requests::Base.new(OAuth2::Server::Request.new).should_not be_valid
  #     end
  #   end
  # end
  #
  # describe "process" do
  #   it "implements the process method" do
  #     subject.should respond_to(:process)
  #   end
  #
  #   it "knows if it has already been processed" do
  #     subject.processed?.should be_false
  #   end
  #
  #   it "raises a NotImplementedError when executing process on the base request class" do
  #     lambda { subject.process }.should raise_error(NotImplementedError)
  #   end
  # end
end

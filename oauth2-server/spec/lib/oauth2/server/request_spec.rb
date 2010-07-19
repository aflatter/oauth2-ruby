require 'spec_helper.rb'

describe OAuth2::Server::Request do
  describe "constructor" do
    it "starts with nil properties" do
      [:http_method, :http_content_type, :params].each do |v|
        subject.send(v).should be_nil
      end
    end

    it "accepts a values hash" do
      lambda { OAuth2::Server::Request.new({}) }.should_not raise_error(ArgumentError)
    end

    it "rejects all parameters that are not values hash" do
      lambda { OAuth2::Server::Request.new("hello world") }.should raise_error(ArgumentError)
    end

    it "parses the provided values hash" do
      values = { :http_method => :get,
                 :http_content_type => 'application/x-www-form-urlencoded',
                 :params => { :hello => 'world' } }

      request = OAuth2::Server::Request.new values

      values.each_key do |k|
        request.send(k).should == values[k]
      end
    end
  end # Constructor

  describe "validations" do
    describe "http_method" do
      before :each do
        @request = OAuth2::Server::Request.new({ :http_content_type => 'application/x-www-form-urlencoded',
                                                 :params => {} })
      end
      it "accepts get and post" do
        [:get, :post].each do |v|
          @request.http_method = v
          @request.should be_valid
        end
      end

      it "rejects all other values" do
        @request.http_method = :dummy
        @request.should_not be_valid

        @request.http_method = "dummy"
        @request.should_not be_valid
      end
    end # http_method
  end # Validations

end # Request

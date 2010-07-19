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
        [:dummy, 'dummy', 123, String, [], {}].each do |v|
          @request.http_method = v
          @request.should_not be_valid
        end
      end
    end # http_method

    describe "http_content_type" do
      before :each do
        @request = OAuth2::Server::Request.new({ :http_content_type => 'application/x-www-form-urlencoded',
                                                 :http_method => :get,
                                                 :params => {} })
      end

      it "accepts application/x-www-form-urlencoded content type" do
        @request.should be_valid
      end

      it "rejects all other values" do
        ['application/json', 'text/html'].each do |v|
          @request.http_content_type = v
          @request.should_not be_valid
        end
      end
    end
  end # Validations

end # Request

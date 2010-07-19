require 'spec_helper.rb'

class HttpMethodValidatorTester
  include ActiveModel::Validations

  attr_accessor :single_http_method, :multiple_http_method

  validates :single_http_method, :http_method => { :method => :get }
  validates :multiple_http_method, :http_method => { :method => [:get, :post] }

  def initialize(single, multiple)
    self.single_http_method = single
    self.multiple_http_method = multiple
  end
end

describe "HTTP Method Validator" do
  it "should be valid" do
    HttpMethodValidatorTester.new(:get, :post).should be_valid
  end

  it "should be invalid" do
    tester = HttpMethodValidatorTester.new(:post, :put)
    tester.should_not be_valid
    tester.errors[:single_http_method].should include 'invalid-request'
    tester.errors[:multiple_http_method].should include 'invalid-request'
  end
end

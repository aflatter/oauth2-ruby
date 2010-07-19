require 'spec_helper.rb'

class HttpContentTypeValidatorTester
  include ActiveModel::Validations

  attr_accessor :http_content_type

  validates :http_content_type, :http_content_type => true

  def initialize(content_type)
    self.http_content_type = content_type
  end
end

describe "HTTP Content Type Validator" do
  it "should be valid" do
    HttpContentTypeValidatorTester.new('application/x-www-form-urlencoded').should be_valid
  end

  it "should not be valid" do
    tester = HttpContentTypeValidatorTester.new('application/json')
    tester.should_not be_valid
    tester.errors[:http_content_type].should include 'invalid-request'
  end
end

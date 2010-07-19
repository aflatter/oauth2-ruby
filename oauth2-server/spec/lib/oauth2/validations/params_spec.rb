require 'spec_helper.rb'

class ParamsValidatorTester
  include ActiveModel::Validations

  attr_accessor :params

  validates :params, :params => true

  def initialize(value = {})
    self.params = value
  end
end

describe "params validator" do
  it "should be valid" do
    ParamsValidatorTester.new({ :hello => :world }).should be_valid
  end

  it "should be invalid" do
    tester = ParamsValidatorTester.new

    ["hello", :world, 123, Hash].each do |v|
      tester.params = v
      tester.should_not be_valid
      tester.errors[:params].should include 'invalid-request'
    end
  end
end

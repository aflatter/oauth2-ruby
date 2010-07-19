require 'spec_helper.rb'

describe OAuth2::Models::ActiveRecord::Client do

  describe "constructor" do
    it "should be valid" do
      subject.should_not be_valid
    end
  end # Constructor

end
require 'spec_helper.rb'

describe OAuth2::Server do
  context "configurations" do

    it "has a hash containing the configuration defaults" do
      OAuth2::Server::DEFAULT_CONFIG.should be_a_kind_of Hash
    end

    it "returns a the defaults configuration hash by default" do
      OAuth2::Server.configurations.should == OAuth2::Server::DEFAULT_CONFIG
    end

  end

end

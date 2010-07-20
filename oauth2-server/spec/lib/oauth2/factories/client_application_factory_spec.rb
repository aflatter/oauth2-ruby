require 'spec_helper.rb'

context OAuth2::Factories::ClientApplicationFactory do
  subject { OAuth2::Factories::ClientApplicationFactory }

  context "finders" do

    describe "find_by_external_id" do
      it "enforces an id to be passed as a parameter" do
        lambda { subject.find_by_external_id }.should raise_error(ArgumentError)
      end

      it "returns nil when no client application is found" do
        subject.find_by_external_id('invalid_id').should be_nil
      end

      it "returns a valid instance of ClientApplication when an existing external id is passed" do
        client_application = subject.find_by_external_id('gnomeslab')

        client_application.should be_a_kind_of(OAuth2::Models::ActiveRecord::ClientApplication)
        client_application.should be_valid
      end
    end #find_by_external_id
  end

end

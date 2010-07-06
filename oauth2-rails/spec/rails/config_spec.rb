require 'spec_helper'
require 'oauth2/rails/config'

describe OAuth2::Rails::Config do
  
  it "has a default of :active_record for adapter" do
    subject.adapter.should == :active_record
  end
  
  it "allows to set adapter" do
    subject.adapter = :foo_bar
    subject.adapter.should == :foo_bar
  end
  
  it "has a default of true for enforce_scopes" do
    subject.enforce_scopes.should == true
  end
  
  it "allows to set enforce_scopes" do
    subject.enforce_scopes = false
    subject.enforce_scopes.should == false
  end
  
  it "has defaults for models" do
    subject.models.should == {:client => :client}
  end
  
  it "allows to set models" do
    models = {:client => :bar}
    subject.models = models
    subject.models.should == models
  end
  
end
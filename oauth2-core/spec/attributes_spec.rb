require 'spec_helper'
require 'oauth2/attributes'

describe OAuth2::Attributes do

  subject do
    klass = Class.new do
      include OAuth2::Attributes
      attributes :foo
    end
    
    klass.new
  end
  
  it "should allow to set an attribute to nil" do
    subject.foo = nil
    subject.foo.should be_nil
  end

  it "should call user defined block if it is registered" do
    foo = stub("some value")
    subject.foo { foo }
    subject.foo.should == foo
  end
  
  it "should return user defined value if defined" do
    foo = stub("some value")
    subject.foo = foo
    subject.foo.should == foo
  end
  
  it "should raise exception if no callback or value is defined" do
    lambda { subject.foo }.should raise_error(RuntimeError)
  end
  
end
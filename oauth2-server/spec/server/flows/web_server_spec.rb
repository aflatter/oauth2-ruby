require 'spec_helper'

shared_examples_for "an object that uses web server flow" do
  
  it "should implement #resource_owner"
  
  it "should implement #verify_resource_owner"
  
  it "should implement #redirect_back"
  
  it "should implement #ticket"
  it "should implement #create_ticket"
  
  it "should implement #render_authorize_form"
  
  it "should implement #authorized?"
  
  it "should implement #create_verification_code"
  
end

describe OAuth2::Server::Flows::WebServer do
  
  context "#request_authorization" do
    
    it "should render authorize form if resource owner is identified" do
      subject.should_receive(:create_ticket).once.with(no_args).ordered
      subject.should_receive(:verify_resource_owner).once.with(no_args).ordered.and_return("Foo")
      subject.should_receive(:render_authorize_form).once.with(no_args).ordered
      subject.request_authorization
    end
    
    it "should verify identity and return if resource owner is not identified" do
      subject.should_receive(:create_ticket).once.with(no_args).ordered
      subject.should_receive(:verify_resource_owner).once.with(no_args).ordered
      subject.should_not_receive(:render_authorize_form)
      subject.request_authorization
    end

  end
  
  context "#grant_authorization" do
    
    it "should create verification code if authorized" do
      subject.should_receive(:authorized?).once.with(no_args).ordered.and_return(true)
      subject.should_receive(:create_verification_code).once.with(no_args).ordered
      subject.should_receive(:redirect_back).once.with(no_args).ordered
      subject.grant_authorization
    end
    
    it "should not create verification code without authorization" do
      subject.should_receive(:authorized?).once.with(no_args).ordered.and_return(false)
      subject.should_not_receive(:create_verification_code)
      subject.should_receive(:redirect_back).once.with(no_args).ordered
      subject.grant_authorization
    end
    
  end
  
end
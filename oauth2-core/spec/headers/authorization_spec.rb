require 'spec_helper'
require 'oauth2/headers/authorization'

describe OAuth2::Headers::Authorization do

  it "should parse a real world cryptographic example" do
    example = <<-EOS
    Token token="vF9dft4qmT",
      nonce="s8djwd",
      timestamp="137131200",
      algorithm="hmac-sha256",
      signature="wOJIO9A2W5mFwDgiDvZbTSMK/PY="
    EOS

    header = OAuth2::Headers::Authorization.parse(example)
    header.token.should     == "vF9dft4qmT"
    header.nonce.should     == "s8djwd"
    header.timestamp.should == "137131200"
    header.algorithm.should == "hmac-sha256"
    header.signature.should == "wOJIO9A2W5mFwDgiDvZbTSMK/PY="
  end

  it "should parse a real world bearer example" do
    example = 'Token token="vF9dft4qmT"'
    header = OAuth2::Headers::Authorization.parse(example)
    header.token.should     == "vF9dft4qmT"
  end

  it "returns attributes in order" do
    attributes = OAuth2::Headers::Authorization::Attributes
    subject.attributes.should be_a(ActiveSupport::OrderedHash)
    subject.attributes.keys.should == attributes
  end

  it "ignores parameters without value using the parse method" do
    example_with_empty_value = <<-EOS
    Token token="vF9dft4qmT",
      nonce=""
    EOS

    example_without_empty_value = <<-EOS
    Token token="vF9dft4qmT"
    EOS

    OAuth2::Headers::Authorization.parse(example_with_empty_value).to_s.should == OAuth2::Headers::Authorization.parse(example_without_empty_value).to_s
  end

  it "ignores parameters without value using the new method" do
OAuth2::Headers::Authorization.new(:token => "vF9dft4qmT", :signature => "").to_s.should == OAuth2::Headers::Authorization.new(:token => "vF9dft4qmT").to_s
  end

  it "builds a header string"

end
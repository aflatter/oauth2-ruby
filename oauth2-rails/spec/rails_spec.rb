describe OAuth2::Rails do

  it "should initialize a configuration" do
    subject.config.should be_a(OAuth2::Rails::Config)
  end
  
  it "should setup its configuration" do
    blk = Proc.new { }
    subject.config.should_receive(:setup).once.and_yield(blk)
    subject.setup(&blk)
  end

end
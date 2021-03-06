require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content" }
  end
  
  it "should create a micropost given valid attributes" do
    @user.microposts.create!(@attr)
  end
  
  describe "user associations" do
    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end
    
    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end
  
  describe "validations" do
    it "should require a valid user id" do
      Micropost.new(@attr).should_not be_valid
    end
    
    it "should have non-blank content" do
      @user.microposts.build(:content => "  ").should_not be_valid
    end
    
    it "should not have content longer than 140 characters" do
      @user.microposts.build(:content => "a" * 141).should_not be_valid
    end
  end
end

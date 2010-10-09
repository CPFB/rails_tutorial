require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App | "
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => @base_title + "Home")
    end
    
    describe "when logged in" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
      
      it "should have a sidebar with '1 micropost' when the user has one micropost" do
        mp = Factory(:micropost, :user => @user)
        get 'home'
        response.should have_selector("span", :class => "microposts", :content => "1 micropost")
      end
      
      it "should have a sidebar with '2 microposts' when the user has two microposts" do
        mp1 = Factory(:micropost, :user => @user)
        mp2 = Factory(:micropost, :user => @user)
        get 'home'
        response.should have_selector("span", :class => "microposts", :content => "2 microposts")
      end
      
      it "should have pagination links when there are over 30 posts" do
        50.times { Factory(:micropost, :user => @user) }
        get 'home'
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/pages/home?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/pages/home?page=2",
                                           :content => "Next")
        
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => @base_title + "Contact")
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end
  
  it "should have the right title" do
    get 'about'
    response.should have_selector("title", :content => @base_title + "About")
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", :content => @base_title + "Help")
    end
  end

end

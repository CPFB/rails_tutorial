class UsersController < ApplicationController
  before_filter :not_signed_in,  :only => [:new, :create]
  before_filter :authenticate,   :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :only => :destroy
  before_filter :not_self,       :only => :destroy
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Twitter Clone!"
      sign_in @user
      redirect_to @user
    else
      @user.password = ""
      @user.password_confirmation = ""
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  private
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    unless current_user.admin?
      flash[:error] = "Only administrators are allowed to destroy users."
      redirect_to(root_path) 
    end
  end
  
  def not_signed_in
    if current_user
      flash[:error] = "You cannot create a new user if you are signed in."
      redirect_to(root_path) 
    end
  end  
  
  def not_self
    if current_user?(User.find(params[:id]))
      flash[:error] = "You cannot delete yourself!"
      redirect_to(root_path)
    end
  end
  
    
end

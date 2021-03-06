class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def index
    @user = User.find(params[:user_id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost destroyed!"
    redirect_back_or root_path
  end
  
  private
  
  def authorized_user
    @micropost = Micropost.find(params[:id])
    unless current_user?(@micropost.user)
      flash[:error] = "You are not authorized to delete this micropost"
      redirect_to root_path unless current_user?(@micropost.user)
    end
  end
  
end

class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
  
def show
	@user = User.find(params[:id])
  #redirect_to root_url and return unless @user.activated
  @microposts = @user.microposts.paginate(page: params[:page])
end


  def new
	
	@user=User.new

  end

  def create
  	@user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      #UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
    #   log_in @user
  		# flash[:success] = "Welcome to the Sample App"
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
 
  # def logged_in_user
  #   unless logged_in?
  #     store_location
  #     flash[:danger] = "Please Log in First !"
  #     redirect_to login_url
  #   end
  # end

 def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User Deleted"
      redirect_to users_url
    end

    def following
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.following.paginate(page: params[:page])
      render 'show_follow'
    end

    def followers
      @title = "Following"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
    end

private

def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
	
end

def admin_user
  redirect_to root_url unless current_user.admin?
end

end
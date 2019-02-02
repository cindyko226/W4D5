class UsersController < ApplicationController
  
  def index
    @user = User.all
  end
  

  def new 
    render :new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = "Something went wrong"
      render 'new'
    end
  end

  def user_params 
    params.require(:user).permit(:username, :session_token, :password_digest, :password)
  end

  def show  
    @user = User.find(params[:id])
    render :show 
  end

end

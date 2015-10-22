class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    sign_in_user!(@user)
    render :show
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :session_token)
    end

end

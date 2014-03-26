class UsersController < ApplicationController
  before_action :require_user, :current_user, only: [:show]
  def new
    if session[:user_id]
      redirect_to home_path
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created!"
      UserMailer.welcome_email(@user).deliver
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :email, :fullname)
  end
end

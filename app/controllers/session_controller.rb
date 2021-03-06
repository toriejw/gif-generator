class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path @user
    else
      flash[:errors] = "Invalid login"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end

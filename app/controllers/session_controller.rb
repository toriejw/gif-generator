class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path @user
    else

    end
  end
end

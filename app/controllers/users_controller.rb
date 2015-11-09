class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def show
    @categories = Category.all
    if session[:user_id] != params[:id].to_i
      render file: '/public/404'
    else
      render "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end

class AccessController < ApplicationController
  def menu
  end

  def login
   @user = User.new
  end

  def attempt_login
    authorized_user = User.authenticate(params[:user][:username], params[:user][:password])
    if authorized_user
      @the_user = User.find_by_username(params[:user][:username])
      session[:user_id] = @the_user.id
      flash[:notice] = "You have successfully logged in"
      redirect_to user_path(session[:user_id])
    else
      flash[:notice] = "Invalid username or password"
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end

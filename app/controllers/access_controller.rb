class AccessController < ApplicationController
  def menu
  end

  def login
   @user = User.new
  end

  def attempt_login
    authorized_user = User.authenticate(params[:user][:username], params[:user][:password])
    if authorized_user
      session[:user_id] = params[:user][:id]
      flash[:notice] = "You have successfully logged in"
      redirect_to users_path
    else
      redirect_to channels_path
    end
  end
end

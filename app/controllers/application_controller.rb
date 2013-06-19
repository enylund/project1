class ApplicationController < ActionController::Base
  before_action :current_user
  helper_method :current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
  	if session[:user_id]
  	  @current_user ||= User.find(session[:user_id]).username
  	else
  	  @current_user = nil
  	end
  end
end

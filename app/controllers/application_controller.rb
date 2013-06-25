class ApplicationController < ActionController::Base
  before_filter :store_location
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!, :except => [:show, :index]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/my|\/login|\/logout/ 
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:previous_url] || root_path
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :avatar) }
  end



end

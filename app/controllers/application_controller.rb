class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  include CheckdinApiHelper

  def current_user
    @current_user || User.find_by_identifier(session[:identifier])
  end
  helper_method :current_user

  def user_signed_in?
    session[:identifier]
  end
  helper_method :user_signed_in?

end

module ApplicationHelper

  def current_user
    @curren_user || User.find_by_identifier(session[:identifier])
  end

  def user_signed_in?
    session[:identifier]
  end

end

class HomeController < ApplicationController
  def index
  	user = User.find_by_identifier session[:identifier]
  	@descrip = get_user_full_description(user) 
  end
end

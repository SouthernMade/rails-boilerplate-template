class HomeController < ApplicationController
  def index
  	@descrip = get_user_full_description(current_user) if current_user
  end
end

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user.nil?
      params[:user][:identifier] = User.build_identifier(params[:user][:email])
      @user = User.new(user_params)
      if @user.save
        checkdin_user = create_checkdin_user(@user)
        @user.update_attribute(:checkdin_user_fk, checkdin_user[:user][:id])
      else
        render :new and return
      end
    end
    session[:identifier] = @user.identifier
    redirect_to root_path
  end

  def facebook_login
    redirect_to facebook_login_url
  end

  def login_callback
    if valid_authentication_request?(params[:digest])
      @user = User.find_by_identifier(params[:client_uid])
      if @user.nil?
        @user = User.new(identifier: params[:client_uid], checkdin_user_fk: params[:user_id])
        @user.save(validate: false)
      end
      session[:identifier] = @user.identifier
      redirect_to root_path
    else
      logger.info "Invalid authentication request."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :identifier, :checkdin_user_fk)
  end
end

class SessionsController < ApplicationController
  def create
    @user = User::find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user.nil?
      render :new
    else
      @user.reset_session_token!
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    session[:session_token] = ""
    current_user.reset_session_token
  end

  def new
    render :new
  end
end

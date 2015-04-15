class SessionsController < ApplicationController
  before_action :prevent_double_login, except: [:destroy]

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
    current_user.reset_session_token!
    session[:session_token] = ""
    redirect_to cats_url
  end

  def new
    render :new
  end

  private
    def prevent_double_login
      redirect_to cats_url unless current_user.nil?
    end
end

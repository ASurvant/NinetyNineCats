class UsersController < ApplicationController
  before_action :prevent_double_login

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :password)
    end

    def prevent_double_login
      redirect_to cats_url unless current_user.nil?
    end
end

class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Create Session & Login
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :password_digest)
    end
end

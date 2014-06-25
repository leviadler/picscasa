class SessionsController < ApplicationController

  before_action :require_signed_out, only: [:new, :create]

  def new

  end

  def create
    @user = User.find_by_credentials(
      user_params[:email],
      user_params[:password]
    )

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:error] = "Invalid email or password"
      render :new
    end

  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
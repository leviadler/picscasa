class UsersController < ApplicationController

  before_action :require_current_user, only: [:edit, :update]
  before_action :require_signed_out, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to root_url
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_url
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @albums = @user.albums.public_album
  end




  private
  def user_params
    params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation, :avatar)
  end

  def require_current_user
    @user = User.find(params[:id])

    if @user != current_user
      #flash[:error] = "You do not have access to that page" #removed b/c will persist
      redirect_to root_url
    end
  end

end

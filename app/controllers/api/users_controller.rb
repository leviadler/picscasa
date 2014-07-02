class Api::UsersController < ApplicationController

  before_action :require_current_user, only: [:edit, :update]
  before_action :require_signed_out, only: [:new, :create]

  # Might need to make a create to use google plus login w/javascript
  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end
  
  # TODO Backbone this???? Maybe
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "Profile updated!"
      redirect_to user_url(@user) #TODO redirect back w/ request.referer
    else

      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  # TODO right now relying on publicAlbum collection
  # but once add pagination will need to fetch from here
  def show
    @user = User.find(params[:id])
    @public_albums = @user.albums.public_album
  end





  private
  def user_params
    params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation, :avatar)
  end

  def require_current_user
    @user = User.find(params[:id])

    if @user != current_user
      flash[:error] = "You do not have access to that page"
      redirect_to root_url
    end
  end

end

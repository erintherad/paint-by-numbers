class UsersController < ApplicationController
 before_filter :authorize, only: [:show]

  def index
  end

  def new
    if current_user
      redirect_to profile_path
    else
      @user = User.new
      render :new
    end
  end

  def create
    if current_user
      redirect_to root_path
    else
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        redirect_to profile_path
      else
        flash[:error] = "Oops! Try again to save your account!"
        redirect_to signup_path
      end
    end
  end

  def edit
  end

  def update
    if current_user
      form_params = params.require(:user).permit(:name, :email, :profile_image)
      current_user.update_attributes(form_params)
      redirect_to profile_path
      # flash[:success] = "Profile successfully updated!"
    else
      redirect_to '/'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end

class UsersController < ApplicationController
  # CJ: include `edit` and `update` in methods to `authorize`
  # will avoid the check for `current_user` you currently have in `update`
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
        # CJ: I would flash the error messages here so the user
        # knows what to fix (`user.errors.full_messages.join("")`)
        flash[:error] = "Oops! Try again to save your account!"
        redirect_to signup_path
      end
    end
  end

  def edit
  end

  def show
    @paintings = current_user.paintings.order(created_at: :desc).page(params[:page]).per(4)
  end

  def update
    if current_user
      form_params = params.require(:user).permit(:name, :email, :avatar)
      current_user.update_attributes(form_params)
      redirect_to profile_path
      # flash[:success] = "Profile successfully updated!"
    else
      # CJ: use `root_path`
      redirect_to '/'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end

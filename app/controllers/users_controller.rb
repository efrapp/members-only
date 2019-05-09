class UsersController < ApplicationController
  before_action :check_authentication, only: :show
  before_action :check_signup, only: [:new, :create]
  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def create
    @user = User.create(user_params)
    
    if @user.valid?
      flash[:success] = "The account has been created"
      sign_in(@user)
      redirect_to @user
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user)
            .permit(:name, :email, :password, :password_confirmation)
    end

    def check_authentication
      redirect_to(root_url) unless signed_in?
    end

    # If a user is already signed in, we don't need to show signup page
    def check_signup
      redirect_to(user_path(current_user)) if signed_in?
    end
end

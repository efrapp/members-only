class UsersController < ApplicationController
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
      redirect_to signin_url
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user)
            .permit(:name, :email, :password, :password_confirmation)
    end
end

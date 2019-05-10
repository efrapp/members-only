class SessionsController < ApplicationController
  before_action :check_signin, only: [:new, :create]
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    
    if @user && @user.authenticate(params[:session][:password])
      sign_in(@user)
      flash[:success] = "Successful sign in."
      redirect_to @user
    else
      flash.now[:danger] = "Email or password invalid."
      render :new
    end
  end

  def delete
    sign_out
    flash[:success] = "Successfuly signed out."
    redirect_to signin_url
  end

  private

    def check_signin
      redirect_to(user_path(current_user)) if signed_in?
    end
end

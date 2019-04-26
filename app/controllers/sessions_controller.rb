class SessionsController < ApplicationController
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
    redirect_to root_url
  end
end

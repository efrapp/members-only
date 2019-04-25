class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # include SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    user.update_attribute(:remember_token, User.generate_remember_token)
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
  end

  def current_user=(user)

  end
end

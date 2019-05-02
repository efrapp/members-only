module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    user.update_attribute(:remember_token, User.digest(User.new_token))
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !!cookies[:remember_token] && !session[:user_id].nil?
  end

  def current_user
    if cookies[:remember_token].present?
      @current_user ||= User.find_by(remember_token: cookies[:remember_token])
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    current_user == user
  end

  def sign_out
    session[:user_id] = nil
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end

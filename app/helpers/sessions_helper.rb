module SessionsHelper

  def logged_in?
    !!cookies[:remember_token]
  end
end

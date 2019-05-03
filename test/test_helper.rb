ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include SessionsHelper

  def sign_in_as(user, password)
    post sessions_path, params: { session: { email: user.email,
                                       password: password } }
    # This line won't work for integretation tests because the session hash
    # isn't known there (we need to define it in a controller, helper, etc)
    # be we can check its information. For unit test we can assign and check
    # the session hash 
    # session[:user_id] = user.id
  end

  def is_signed_in?
    !session[:user_id].nil?
  end
end

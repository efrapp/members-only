require 'test_helper'

class SigninTest < ActionDispatch::IntegrationTest

  def setup
    @non_signed_in = users(:efrain)
  end
  
  test "signin with wrong information should fail" do
    get signin_path
    assert_template 'sessions/new'
    post sessions_path, params: { session: { email: '',
                                          password: '' } }
    assert_not flash.empty?
    assert_template 'sessions/new'
  end

  test "signin with valid information should be a success" do
    post sessions_path, params: { session: { email: @non_signed_in.email,
                                             password: 'password' } }
    assert_not flash.empty?
    assert is_signed_in?
    assert_redirected_to user_url(@non_signed_in)
  end
end

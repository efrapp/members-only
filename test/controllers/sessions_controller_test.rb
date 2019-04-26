require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:efrain)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "when user signed in the remember token change" do
    post sessions_path, params: { session: { email: @user.email,
                                             password: 'password' } }
    # assert_template 'users/show'
    assert_not_equal @user.remember_token, @user.reload.remember_token
  end

end

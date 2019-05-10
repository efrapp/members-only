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

  test "sign out user" do
    # Login first
    post sessions_path, params: { session: { email: @non_signed_in.email,
                                             password: 'password' }}
    assert_redirected_to user_url(@non_signed_in)
    # then sign out
    delete sign_out_path
    assert_redirected_to signin_url
    assert_not is_signed_in?
  end

  test "non signed in user should access only to post index view" do
    get user_url(@non_signed_in)
    assert_redirected_to root_url
    get new_user_post_url(@non_signed_in)
    assert_redirected_to root_url
    get user_posts_url(@non_signed_in)
    assert_response :success
  end

  test "sign in user should access to all views" do
    sign_in_as(@non_signed_in, 'password')
    assert is_signed_in?
    get user_url(@non_signed_in)
    assert_response :success
    get new_user_post_url(@non_signed_in)
    assert_response :success
    get user_posts_url(@non_signed_in)
    assert_response :success
  end
end

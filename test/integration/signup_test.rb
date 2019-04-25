require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest

  test "signup form with empty fields should return errors" do
    get signup_path
    assert_template 'users/new'
    post users_path, params: { user: { name: '',
                                       email: '',
                                       password: '',
                                       password_confirmation: '' } }
    assert_template 'users/new'
    assert_select '.field_with_errors'
    assert_not assigns(:user).errors.empty?
  end

  test "signup form with valid fields should create the user" do
    get signup_url
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Efrain',
                                        email: 'e@p.p',
                                        password: '12345',
                                        password_confirmation: '12345' } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end

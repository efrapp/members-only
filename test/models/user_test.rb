require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: 'Test User', email: 'tu@g.c',
                     password: '123456', password_confirmation: '123456')
  end

  test "user with right information should be valid" do
    assert @user.valid?
  end

  test "validate presence of name" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "validate presence of email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "validate presence of password" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "user name should be maximum 50 characters long" do
    @user.name = "e" * 51
    assert_not @user.valid?
  end

  test "user password should be at least 5 characters long" do
    @user.password = "1234"
    assert_not @user.valid?
  end
end

require 'test_helper'

class PostCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:efrain)
  end

  test "create a post with invalid information should be failed" do
    sign_in_as(@user, 'password')
    assert_equal is_signed_in?, true
    post user_posts_path @user, params: { post: { title: '',
                                                  body: '' } }
    assert_template 'posts/new'
    assert_select '.field_with_errors', count: 4
    assert_select '#error_explanation'
  end

  test "create a post with valid information should be success" do
    sign_in_as(@user, 'password')
    assert_equal is_signed_in?, true
    post user_posts_path @user, params: { post: { title: 'Firs post',
                                                  body: 'Content' } }
    assert_redirected_to user_posts_url
    assert_not flash.empty?
  end
end

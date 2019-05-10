require 'test_helper'

class ListPostsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:efrain)
  end

  test "list of post should be ordered by most recent" do
    get posts_url
    posts = assigns(:posts)
    assert_operator posts[0].created_at, :>, posts[1].created_at
  end

  test "post author shouldn't appear for non-signed in users" do
    get posts_url
    assert_select '.author', count: 0
  end

  test "post author should appear for signed in users" do
    sign_in_as(@user, 'password')
    get posts_url
    assert_select '.author'
  end
end

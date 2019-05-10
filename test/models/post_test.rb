require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:efrain)
    @post = @user.posts.build(title: 'First post', body: 'Firs post content')
  end

  test "validate presence of title" do
    @post.title = "  "
    assert_not @post.valid?
  end

  test "validate presence of body" do
    @post.body = "  "
    assert_not @post.valid?
  end
end

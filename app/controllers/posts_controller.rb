class PostsController < ApplicationController
  before_action :check_authentication, except: :index
  before_action :get_user, only: [:new, :create]
  before_action :verify_user, only: [:new, :create]
  def new
    @post = @user.posts.build
  end

  def index
    @posts = Post.all.order_by_recent
  end

  def create
    @post = @user.posts.new(post_params)

    if @post.save
      flash[:success] = 'Post created successfully.'
      redirect_to user_posts_url
    else
      render :new
    end
  end

  private

    def get_user
      @user = User.find_by(id: params[:user_id])
    end
  
    def verify_user
      unless current_user?(@user)
        flash[:warning] = 'Access denied.'
        redirect_to @user
      end
    end

    def check_authentication
      unless signed_in?
        flash[:warning] = 'Please signin first.'
        redirect_to root_url
      end
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end

class PostsController < ApplicationController
  before_action :authenticate_user!

  # GET /posts profile page, current user posts
  def profile
    @posts = current_user.posts
    render json: posts, status: :ok
  end

  # TODO
  # GET /posts all public posts & friends private ones
  def index # Home
    @posts = Post.where(is_public: true).order("created_at DSEC")
    render json: posts, status: :ok
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /post/1
  def destroy
    @post = current_user.posts.find(post_params)
    @post.destroy
  end

  private
    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:caption, :is_public, :photo)
    end
end

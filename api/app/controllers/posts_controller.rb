class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:profile]

  # GET /posts profile page, current user posts
  def profile
    if @user == current_user or current_user.friends.include?(@user)
      @posts = @user.posts
    else
      @posts = @user.posts.where(is_public: true)
    end

    @posts = @posts.order("created_at DESC")
    render json: @posts, status: :ok
  end

  # TODO
  # GET /posts all public posts & friends private ones
  def index # Home
    @posts = Post.where(is_public: true).or(Post.where(user: users)).or(Post.where(user: current_user))
    @posts = @posts.order("created_at DESC")
    render json: @posts.as_json.merge(photo: @post.photo.url(:medium)), :include => :user, status: :ok
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)
    @post.photo = Paperclip.io_adapters.for(post_params[:photo])

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /post/1
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
  end

  private
    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:caption, :is_public, :photo)
    end

    def get_user
      if params.key?(:id)
        @user = User.find(params[:id])
      else
        render status: :unauthroized
      end
    end
end

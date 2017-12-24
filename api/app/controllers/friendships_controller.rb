class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_friend, only: [:destroy]

  # GET /friendships
  # gets all friends of a certain user
  def index
    render json: set_photo(current_user.friends), status: :ok
  end

  # POST /friendships
  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      render json: @friendship, status: :created
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friendships/:id
  def destroy
    if current_user.friends.include?(@friend)
      Friendship.find_by(user_id: current_user.id, friend_id: @friend.id).destroy
    else
      render status: 401
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end

    def get_friend
      if params.key?(:id)
        @friend = User.find(params[:id])
      else
        render status: :unauthroized
      end
    end

    def set_photo(users)
      users = users.to_a
      users.map! do |user|
        user[:profile_picture_file_name] = user.profile_picture.url(:medium)
        user = user.as_json
      end
      return users
    end
end

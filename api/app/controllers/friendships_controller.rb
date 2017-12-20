class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  # GET /friendships
  # gets all friends of a certain user
  def index
    render json: current_user.friends, status: :ok
  end

  # POST /friendships
  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      render json: @friendship, status: :created, location: @friendship
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friendships/
  # body:
  # {
  #   user_id,  <= must equal the id of the current loggedin user
  #   friend_id
  # }
  def destroy
    if current_user[:id] == friendship_params[:user_id]
      Friendship.find(friendship_params).destroy
    else
      render status: 401
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
end

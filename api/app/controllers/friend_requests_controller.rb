class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:show, :update, :destroy, :confirm, :reject]

  before_action :authenticate_user!

  # GET /friend_requests
  # Returns pending friend requests of the current logged in user
  def index
    @friend_requests = current_user.recieved_friend_requests
      .where(:status => :pending).includes(:requester)

    render json: @friend_requests
  end

  # GET /friend_requests/sent
  # Returns a list of sent friend requests
  def sent_index
    @friend_requests = current_user.sent_friend_requests.includes(:asked)
    render json: @friend_requests
  end

  # GET /friend_requests/1
  def show
    render json: @friend_request
  end

  # POST /friend_requests
  def create
    @friend_request = FriendRequest.new(requester_user_id: current_user[:id],
      asked_user_id: friend_request_params[:asked_user_id])

    if @friend_request.save
      render json: @friend_request, status: :created
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friend_requests/1
  def destroy
    @friend_request.destroy
  end

  def confirm
    if current_user[:id] != @friend_request[:asked_user_id]
      render status: 401
    else
      current_user.friends << User.find(@friend_request[:requester_user_id])
      @friend_request.status = :accepted
      render status: 200
    end
  end

  def reject
    if current_user[:id] != @friend_request[:asked_user_id]
      render status: 401
    else
      # change the friend request status to rejected
      @friend_request.status = :rejected
      render status: 200
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend_request
      @friend_request = FriendRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def friend_request_params
      params.require(:friend_request).permit(:asked_user_id)
    end
end

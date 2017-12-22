class UserController < ApplicationController

  before_action :authenticate_user!, only: [:fetch_current_user, :update_profile_image, :show, :update]
  before_action :get_user, only: [:show]

  def show
    selected = [:id, :nickname, :profile_picture, :first_name, :last_name, :hometown,
       :email, :marital_status, :gender]
    selected << [:birthdate, :about_me] if current_user.friends.include?(@user)
    render json: @user.slice(selected), status: :ok
  end

  # PUT /user
  def update
    current_user.update(user_params)
  end

  def update_profile_image
    encoded_image = image_params[:data]
    content_type = image_params[:content_type]
    profile_picture = Paperclip.io_adapters.for(encoded_image)
    profile_picture.original_filename = image_params[:filename]
    current_user.profile_picture = profile_picture

    # current_user.update_attribute :profile_picture, decode_image
    current_user.save
    render json: current_user.profile_picture, statue: :ok
  end

  def fetch_current_user
    render json: current_user, status: :ok
  end

  private
  def image_params
    params.require(:image).permit(:data, :content_type, :filename)
  end

  def get_user
    if params.key?(:id)
      @user = User.find(params[:id])
    else
      render status: :unauthroized
    end
  end

  def user_params
    params.require(:user).permit(:nickname,:first_name, :last_name, :hometown,
    :email, :marital_status, :gender, :birthdate, :about_me)
  end
end

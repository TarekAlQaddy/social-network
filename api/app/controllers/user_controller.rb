class UserController < ApplicationController

  before_action :authenticate_user!, only: [:fetch_current_user, :update_profile_image,
    :show, :update, :add_phone, :delete_phone]

  before_action :get_user, only: [:show]

  def show
    selected = [:id, :nickname, :profile_picture, :first_name, :last_name, :hometown,
       :email, :marital_status, :gender]
    selected << [:birthdate, :about_me] if current_user.friends.include?(@user)
    # @user.profile_picture = @user.profile_picture.url(:medium)
    render json: @user.slice(selected).merge(profile_picture: @user.profile_picture.url(:medium)),
       include: :phones, status: :ok
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

  # POST
  def add_phone
    @phone = current_user.phones.create(phone_params)

    if @phone.save
      render json: @phone, status: :created
    else
      render json: @phone.errors, status: :unprocessable_entity
    end
  end

  # DELETE/1
  def delete_phone
    @phone.find(phone_params)
    @phone.destroy
  end

  def fetch_current_user
    render json: current_user, :include => :phones, status: :ok
  end

  private
    def image_params
      params.require(:image).permit(:data, :content_type, :filename)
    end

    def phone_params
      params.require(:phone).permit(:number)
    end

    def user_params
      params.require(:user).permit(:nickname,:first_name, :last_name, :hometown,
      :email, :marital_status, :gender, :birthdate, :about_me)
    end

    def get_user
      if params.key?(:id)
        @user = User.find(params[:id])
      else
        render status: :unauthroized
      end
    end

end

class UserController < ApplicationController

  before_action :authenticate_user!, only: [:fetch_current_user, :update_profile_image]

  def show
    if params.key?(:id)
      render json: User.select(:id, :nickname, :profile_picture, :first_name,
        :last_name, :hometown, :birthdate, :email, :marital_status,
        :about_me, :gender).find(params[:id]), :include => :phones, status: :ok
    else
      render status: :unauthroized
    end
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
    @phone = current_user.posts.create(phone_params)

    if @phone.save
      render json: @phone, status: :created, location: @phone
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

    def decode_image
      decoded_data = Base64.decode64(image_params[:data])
      data = StringIO.new(decoded_data)
      return data
    end

    def phone_params
      params.require(:phone).permit(:number)
    end
end

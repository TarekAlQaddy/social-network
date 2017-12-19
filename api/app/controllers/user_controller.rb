class UserController < ApplicationController

  before_action :authenticate_user!, only: [:fetch_current_user]

  def show
    if params.key?(:id)
      render json: User.select(:id, :nickname, :image, :first_name,
        :last_name, :hometown, :birthdate, :email, :marital_status,
        :about_me, :gender).find(params[:id]), status: :ok
    else
      render status: :unauthroized
    end
  end

  def fetch_current_user
    render json: current_user, status: :ok
  end

end

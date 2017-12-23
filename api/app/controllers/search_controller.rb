class SearchController < ApplicationController
  # before_action :authenticate_user!

  def search
    search_value = "%" + search_params[:value] + "%"
    search_value.downcase!
    case search_params[:type]
    when "email"
      results = User.where("LOWER(email) LIKE ?", search_value)
    when "caption"
      results = Post.where("LOWER(caption) LIKE ?", search_value)
    when "hometown"
      results = User.where("LOWER(hometown) LIKE ?", search_value)
    when "name"
      results = User.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", search_value, search_value)
    else
      results = {}
    end
    if search_params[:type] === 'caption'
      render json: results, status: :ok, :include => :user
    else
      render json: results, status: :ok
    end
  end


  private
  def search_params
    params.require(:search).permit(:type, :value)
  end
end

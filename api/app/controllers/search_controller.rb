class SearchController < ApplicationController
  # before_action :authenticate_user!

  def search
    search_value = "%" + search_params[:value] + "%"
    search_value.downcase!
    case search_params[:type]
    when "email"
      results = User.where("LOWER(email) LIKE ?", search_value)
      results = add_user_profile_picture(results)
    when "caption"
      results = Post.where("LOWER(caption) LIKE ?", search_value).order("created_at DESC")
      results = add_image_and_user_to_post(results)
    when "hometown"
      results = User.where("LOWER(hometown) LIKE ?", search_value)
      results = add_user_profile_picture(results)
    when "name"
      results = User.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", search_value, search_value)
      results = add_user_profile_picture(results)
    else
      results = {}
    end

    render json: results, status: :ok
  end


  private
    def search_params
      params.require(:search).permit(:type, :value)
    end

    def add_image_and_user_to_post(posts)
      posts = posts.to_a
      posts.map! do |post|
        user = post.user
        user[:profile_picture_file_name] = user.profile_picture.url(:medium)
        begin
          photo_url = post.photo.url
          post = post.as_json
          post[:user] = user
          post[:photo_url] = photo_url
        rescue Paperclip::AdapterRegistry::NoHandlerError
          post = post.as_json
          post[:user] = user
          post[:photo_url] = photo_url
        end
        post
      end
      return posts
    end

    def add_user_profile_picture(users)
      users = users.to_a
      users.map! do |user|
        user[:profile_picture_file_name] = user.profile_picture.url(:medium)
        user = user.as_json
      end
      return users
    end
end

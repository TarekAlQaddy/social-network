class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      params = [ :first_name, :last_name, :nickname, :gender,
        :hometown, :about_me, :birthdate, :marital_status, :profile_picture ]

      devise_parameter_sanitizer.permit(:sign_up, keys: params)
      devise_parameter_sanitizer.permit(:edit, keys: params)
    end

end

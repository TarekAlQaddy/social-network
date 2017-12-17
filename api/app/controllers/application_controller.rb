class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nickname, :gender, :hometown, :about_me, :birthdate])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nickname, :gender, :hometown, :about_me, :birthdate])
    end

end

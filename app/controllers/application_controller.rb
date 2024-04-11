class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!, except: %i[home]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:document, :first_name, :last_name, :department])
    devise_parameter_sanitizer.permit(:account_update, keys: [:document, :first_name, :last_name, :department])
  end
end

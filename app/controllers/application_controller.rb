class ApplicationController < ActionController::Base
  #   protect_from_forgery with: :exception

  #   before_action :update_allowed_parameters, if: :devise_controller?

  #   protected

  #   def update_allowed_parameters
  #     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  #     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  #   end
  # end

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?
  def after_sign_out_path_for(_resource_or_scope)
    user_session_path
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :posts_counter, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :posts_counter, :email,
               :password, :password_confirmation, :current_password)
    end
  end
end

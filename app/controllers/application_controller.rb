class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
    	keys: [:account_name, :profile_image_id, :postcode, :address, :tel, :is_active])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_top_path
    when Customer
      root_path
    end
  end
end

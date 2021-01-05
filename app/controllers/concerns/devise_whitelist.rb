module DeviseWhitelist
  extend ActiveSupport::Concern
  included do
    before_action :configure_permitted_parameters, if: :devise_controller?
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name , :slug  , :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name , :slug , :role])
  end
  def after_sign_in_path_for(resource)
    profile_index_path
  end
end
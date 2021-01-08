class ApplicationController < ActionController::Base
  include DeviseWhitelist
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "You don't have right access to access this page"
    redirect_to (request.referrer || root_path)
  end

end

class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  private
  def user_not_authorized
    flash[:alert] = "You don't have right access to access this page"
    redirect_to (request.referrer || root_path)
  end
end

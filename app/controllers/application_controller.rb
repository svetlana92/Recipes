class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Can't touch this, Ta-ra-ra-ra"
    redirect_to(request.referrer || root_path)
  end
end

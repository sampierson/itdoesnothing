class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :conditionally_logout_non_admins

  def conditionally_logout_non_admins
    if user_signed_in? && AppConfiguration.site_availability <= SiteAvailability::ADMINS_ONLY && !current_user.admin?
      sign_out_and_redirect(:user)
      flash[:alert] = SiteAvailability.maintenance_message
    end
  end
end

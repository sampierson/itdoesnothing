class RegistrationsController < Devise::RegistrationsController
  before_filter :conditionally_disable_registration

  private

  def conditionally_disable_registration
    if AppConfiguration.site_availability <= SiteAvailability::PREVENT_NEW_SIGNUPS
      flash[:alert] = SiteAvailability.no_signup_message
      redirect_to root_path
    end
  end
end

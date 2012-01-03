class SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    if AppConfiguration.site_availability <= SiteAvailability::PREVENT_USER_LOGINS && !resource.admin?
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      flash[:alert] = SiteAvailability.maintenance_message
      redirect_to root_path
    else
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end
end


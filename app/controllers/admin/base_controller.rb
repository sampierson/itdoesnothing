module Admin
  class BaseController < ApplicationController
    before_filter :before_filters_work
    before_filter :authenticate_user!
    before_filter :require_admin

    private

    def before_filters_work
      puts "SAM: before filters work"
    end

    def require_admin
      puts "SAM in require_admin, roles = #{current_user.roles.inspect}"
      unless current_user.admin? || current_user.developer?
        flash[:alert] = "Sorry you are not authorized to access that page"
        redirect_to root_url
      end
    end
  end
end

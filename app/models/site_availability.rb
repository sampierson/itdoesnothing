class SiteAvailability < EnumerateIt::Base
  associate_values(
    :down                => 0,
    :admins_only         => [20,  "Admins only"],
    :prevent_user_logins => [40,  "Prevent user logins"],
    :prevent_new_signups => [80,  "Prevent new signups"],
    :fully_operational   => [100, "Fully operational"]
  )

  class << self
    def for_form
      to_a.reject { |x| x.last == DOWN }.sort { |x,y| x.last <=> y.last }.reverse
    end

    def maintenance_message
      maintenance_reason = AppConfiguration.instance.maintenance_message || t('site_availability.please_try_later')
      I18n.t('site_availability.maintenance', :detail => maintenance_reason)
    end

    def no_signup_message
      maintenance_reason = AppConfiguration.instance.maintenance_message || t('site_availability.please_try_later')
      I18n.t('site_availability.sorry_no_signups', :detail => maintenance_reason)
    end
  end
end

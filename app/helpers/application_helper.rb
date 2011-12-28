module ApplicationHelper

  def site_title_helper
    "ItDoesNothing" + (Rails.env == 'production' ? "" : (" " + Rails.env))
  end

  def body_css_classes
    [
      underscored_controller_name,
      underscored_controller_name + "_" + action_name
    ].join(" ")
  end

  def underscored_controller_name
    controller.class.name.underscore.gsub('/', '_')
  end
end

module ApplicationHelper
  def rails_controller_name
    "rails--#{controller_name.tr('_', '-')}"
  end
end

module ApplicationHelper
  def css_class_for_active_link(route)
    return 'active active--underline' if request.path == route
  end
end

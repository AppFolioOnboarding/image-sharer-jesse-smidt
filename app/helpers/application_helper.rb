module ApplicationHelper
  def link_active?(route)
    return 'active' if request.path == route
  end
end

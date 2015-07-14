module MyCustomHelper
  def will_show_nav_items_for?(action, controller)
    params[:action] == action && params[:controller] == controller
  end

  def class_active(action, controller)
    if params[:action] == action && params[:controller] == controller
      'active '
    end
  end
end

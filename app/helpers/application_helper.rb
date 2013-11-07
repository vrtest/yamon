# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def logged?

    session[:user_id] != nil
  end

  def is_menu_active? menu

    controller.controller_name == menu ? "active" : ""
  end

  def title(page_title)

    content_for :title, page_title.to_s
  end

end

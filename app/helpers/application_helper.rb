# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def logged?
    session[:user_id] != nil
  end

end

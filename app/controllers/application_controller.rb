class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_path = current_user.present? ? root_url : new_user_session_path
    redirect_to redirect_path, :alert => exception.message
  end
end

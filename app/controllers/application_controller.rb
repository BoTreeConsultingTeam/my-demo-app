class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  # session checking for customer available or not
  def session_checking
    if current_admin.nil? && session[:customer].nil?
      redirect_to root_path
    end
  end

  def admin_only
    redirect_to '/admins/index' if current_admin
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # session checking for customer available or not
  def session_checking
    if current_admin.nil?
      redirect_to root_path if session[:customer].nil?
    end
  end

  def admin_only
    if current_admin
      redirect_to '/admins/index'
    end
  end

end

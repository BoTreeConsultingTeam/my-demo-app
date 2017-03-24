class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_admin
    if current_admin.nil?
      redirect_to root_path
    end
  end

end

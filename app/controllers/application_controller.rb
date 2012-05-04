class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :except => [:index, :show], :unless => :devise_controller?

#  before_filter :authenticate_user!

#  def index 
#  end

#  def new
#    @listing = Listing.new
#  end

 rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_dashboard_path, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end
end

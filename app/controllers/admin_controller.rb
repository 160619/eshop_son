class AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :admin_user_verify!

  layout 'application'
  def index
  end

  def admin_user_verify!
    
  end
end

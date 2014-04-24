class AdminController < ApplicationController
  before_action :current_user, :require_user, :ensure_admin

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end

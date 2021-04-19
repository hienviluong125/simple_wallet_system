class Dashboard::BaseController < ApplicationController
  include Dashboard::BaseHelper
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout 'dashboard'

  private

  def authenticate_admin!
    return if enough_permission?(%w[superadmin admin])

    redirect_to root_path, alert: 'The page you are looking for does not exist'
  end
end
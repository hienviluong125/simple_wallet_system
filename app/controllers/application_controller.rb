class ApplicationController < ActionController::Base
  def authorization(roles=[])
    return false if current_user.blank?

    roles.include? current_user.role
  end
end

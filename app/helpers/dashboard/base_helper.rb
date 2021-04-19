module Dashboard::BaseHelper
  def enough_permission?(roles = [])
    roles.include? current_user.role
  end
end
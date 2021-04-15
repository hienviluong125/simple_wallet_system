class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def can_update_password?(current_password, new_password, new_password_confirmation)
    if current_password.blank?
      self.errors[:base] << "Current password can't be blank"
      return false
    end

    if new_password.blank?
      self.errors[:base] << "New password can't be blank"
      return false
    end

    if new_password_confirmation.blank?
      self.errors[:base] << "New password confirmation can't be blank"
      return false
    end

    if new_password != new_password_confirmation
      self.errors[:base] << "New password doesn't match new password confirmation"
      return false
    end

    if !valid_password?(current_password)
      self.errors[:base] << "Current password not correct"
      return false
    end

    true
  end
end

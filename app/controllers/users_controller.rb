class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def profile
    @transactions = current_user.transactions
  end

  def update_profile
    if @user.update_without_password(users_params)
      redirect_to profile_users_path, notice: "Your account's profile updated successfully"
    else
      render :profile
    end
  end

  def change_password; end

  def update_password
    can_change_password = @user.can_update_password?(
      users_params[:current_password],
      users_params[:new_password],
      users_params[:new_password_confirmation]
    )

    return render :change_password unless can_change_password

    return render :change_password unless @user.update(
      password: users_params[:new_password],
      password_confirmation: users_params[:new_password_confirmation]
    )

    sign_in @user, bypass: true
    redirect_to profile_users_path, notice: "Your account's password updated succesfully"
  end

  private

  def set_user
    @user = current_user
  end

  def users_params
    params
      .require(:user)
      .permit(
        :first_name,
        :last_name,
        :gender,
        :current_password,
        :new_password,
        :new_password_confirmation
      )
  end
end

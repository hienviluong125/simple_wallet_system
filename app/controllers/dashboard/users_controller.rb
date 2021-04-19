class Dashboard::UsersController < Dashboard::BaseController
  before_action :set_user, only: %w[edit update]
  before_action :check_is_superadmin, only: %w[edit update]
  before_action :check_permission, only: :update

  def index
    @pagy, @users = pagy(User.all)
  end

  def edit; end

  def update
    if @user.update(users_params)
      redirect_to dashboard_users_path, notice: "User's info updated succesfully"
    else
      render :edit
    end
  end

  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :gender, :role)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def check_is_superadmin
    if @user.role == "superadmin" && !enough_permission?(["superadmin"])
      return redirect_to dashboard_users_path(@user), alert: 'You need permission to perform this action'
    end
  end

  def check_permission
    return if users_params[:role].blank?

    return if enough_permission?(['superadmin'])

    redirect_to edit_dashboard_user_path(@user), alert: 'You need permission to perform this action'
  end
end
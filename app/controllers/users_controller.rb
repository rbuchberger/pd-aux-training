# Handles user management for admins
class UsersController < ApplicationController
  # All of these actions are part of the admin menu. Normal account management
  # is handled by Devise.

  def index
    authorize User

    @users_active =
      User.where(role: %i[deputy trainer admin], deleted_at: nil)
          .order(role: :desc, last_name: :asc)
    @users_pending =
      User.where(role: :pending, deleted_at: nil)
          .order(:last_name)
    @users_deactivated =
      User.where.not(deleted_at: nil)
          .order(:last_name)
  end

  def show
    @user = user
  end

  def edit
    @user = user
  end

  def update
    @user = user
    if @user.update(user_params)
      flash[:success] = 'User updated!'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'Could not update user!'
      render :edit
    end
  end

  def destroy
    @user = user
    if @user.destroy
      flash[:success] = 'User deleted!'
      redirect_to users_path
    else
      flash[:danger] =
        'Cannot delete the last administrator. Please create another first!'
      redirect_to user_path(@user)
    end
  end

  # Custom action allowing trainers to approve pending users
  def approve
    @user = user
    if @user.approve
      flash[:success] =
        "User approved! Their role has been set to deputy, and they can now
        log in."
    else
      flash[:danger] = 'Could not approve user.'
    end

    redirect_to user_path(@user)
  end

  # Custom action allowing trainers to reject pending users.
  def reject
    @user = user
    if @user.reject
      flash[:success] =
        "User rejected! Their account has been deleted, and they will not be
        able to log in."
      redirect_to users_path
    else
      flash[:danger] = 'Could not reject user.'
      redirect_to user_path(@user)
    end
  end

  # Preferred method for turning people off:
  def deactivate
    @user = user
    if @user.deactivate
      flash[:success] = 'User deactivated.'
      redirect_to user_path(@user)
    else
      flash[:danger] =
        'Please create another administrator before deactivating this account.'
      redirect_to edit_user_path(@user)
    end
  end

  # because it lets you turn them back on again.
  def reactivate
    @user = user
    if @user.reactivate
      flash[:success] = 'User reactivated! Their role has been set to deputy.'
      redirect_to user_path(@user)
    else
      flash[:alert] = 'Could not reactivate user.'
      redirect_to edit_user_path(@user)
    end
  end

  # Index training requirements by completion status, based on a particular user
  def lessons
    @user = user
    authorize @user
    @lessons_complete = @user.lessons.all.order(:title)
    @lessons_incomplete = Lesson.all.order(:title).to_a - @lessons_complete.to_a
  end

  private

  def user
    user = User.unscoped.find(params[:id])
    authorize user
    user
  end

  def user_params
    params.require(:user)
          .permit(:first_name, :last_name, :badge_number, :role, :email)
  end
end

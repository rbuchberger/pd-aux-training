class UsersController < ApplicationController
	
	def index
    authorize User
    @users_active = User.where.not(role: :pending).order(:role, :last_name)
    @users_pending = User.unscoped.where(role: :pending).order(:last_name)
    @users_deactivated = User.unscoped.where.not(deleted_at: nil).order(:last_name)
	end
	
	def show
		@user = get_user
	end
	
	def edit 
		@user = get_user
	end
	
	def update
		@user = get_user
		if @user.update(user_params)
			flash[:success] = "User updated!"
			redirect_to users_path
		else 
			flash[:danger] = "Could not update user!"
			render edit_user_path(@user)
		end
	end
	
	def destroy
		@user = get_user
		if @user.destroy
			flash[:success] = "User deleted!"
			redirect_to users_path
		else
			flash[:danger] = "Could not delete user."
			redirect_to user_path(@user)
		end
	end
	
	# Custom action allowing trainers to approve pending users
	def approve
		@user = get_user
		if @user.pending?
			@user.role = :deputy
			if @user.save
				flash[:success] = "User approved!"
				redirect_to user_path(@user)
			else
				flash[:danger] = "Could not approve user."
				redirect_to user_path(@user)
			end
		end
	end
	
	# Custom action allowing trainers to reject pending users. 
	def reject
		@user = get_user
		if @user.pending?
			if @user.destroy
				flash[:success] = "User rejected!"
				redirect_to users_path
			else
				flash[:danger] = "Could not reject user."
			end
		end
	end
  
  # Preferred method for turning people off.
  def deactivate
    @user = get_user
    @user.deleted_at = Time.zone.now
    @user.role = :deputy
    if @user.save
      flash[:success] = "User deactivated."
    else
      flash[:danger] = "Could not deactivate user."
    end
    redirect_to user_path(@user)
  end

  # because it lets you turn them back on again. 
  def reactivate
    @user = get_user
    @user.deleted_at = nil
    if @user.save
      flash[:success] = "User reactivated"
    else
      flash[:alert] = "Could not reactivate user."
    end
    redirect_to user_path(@user)
  end

	# Index training requirements by completion status, based on a particular user
	def lessons
	  @user = get_user
    authorize @user
    @lessons_complete = @user.lessons.all.order(:title)
    # Surely there's a more efficient way to do this:
    @lessons_incomplete = (Lesson.all.order(:title).to_a - @lessons_complete.to_a)  
	end
	
	private
	
	def get_user
    user = User.unscoped.find(params[:id])
		authorize user
		user
	end
	
	def user_params
		params.require(:user).permit(:first_name, :last_name, :badge_number, :role, :email)
	end
end

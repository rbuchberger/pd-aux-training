class UsersController < ApplicationController
	
	def index
		@users = User.all.order(:last_name)
		authorize @users
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
	
	private
	
	def get_user
		user = User.find(params[:id])
		authorize user
		user
	end
	
	def user_params
		params.require(:user).permit(:first_name, :last_name, :badge_number, :role, :email)
	end
end

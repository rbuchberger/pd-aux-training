class UsersController < ApplicationController
	before_action :get_user, except: :index
	before_action :isadmin?, except: [:index, :show, :approve, :reject]
	before_action :istrainer?, only: [:index, :show, :approve, :reject]
	
	def index
		@users = User.all.order(:last_name)
	end
	
	def show
		
	end
	
	def edit 
		
	end
	
	def update
		if @user.update(user_params)
			flash[:success] = "User updated!"
			redirect_to users_path
		else 
			flash[:danger] = "Could not update user!"
			render edit_user_path(@user)
		end
	end
	
	def destroy
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
		@user = User.find(params[:id])
	end
	
	def isadmin?
		# TODO: this and istrainer? break when a non-logged in user tries to access them. 
		redirect_to root_path	unless current_user.admin?
	end
		
	def istrainer?
		redirect_to root_path	unless current_user.trainer? || current_user.admin?
	end
		
	def user_params
		params.require(:user).permit(:first_name, :last_name, :badge_number, :role, :email)
	end
end

class UsersController < ApplicationController
	before_action :get_user, except: :index
	before_action :isadmin?, except: [:index, :show, :approve, :reject]
	before_action :istrainer?, only: [:index, :show, :approve, :reject]
	
	def index
		@users = User.all
	end
	
	def show
		
	end
	
	def edit 
		
	end
	
	def update
		@user.update!(user_params)
		redirect_to users_path
	end
	
	def destroy
		@user.destroy!
		redirect_to users_path
	end
	
	# Custom action allowing trainers to approve pending users
	def approve
		if @user.pending?
			@user.role = :deputy
			@user.save!
			redirect_to user_path
		end
	end
	# Custom action allowing trainers to reject pending users. 
	def reject
		if @user.pending?
			@user.destroy!
			redirect_to users_path
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

		# When updating users, if you change the password devise will fail to validate.
		# This statement strips it, to prevent that. Except it breaks the update form, so that needs fixed. 
		# if params[:user][:password].blank?
		#   params[:user].delete(:password)
		#   params[:user].delete(:password_confirmation)
		# end
	end
end

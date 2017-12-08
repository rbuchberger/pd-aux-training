class UsersController < ApplicationController
	before_action :get_user, except: :index
	def index
		@users = User.all
	end
	
	def edit 
		
	end
	
	def update
		# When updating users, if you change the password devise will fail to validate.
		# This statement strips a changed password, to prevent that. 
		if params[:user][:password].blank?
		  params[:user].delete(:password)
		  params[:user].delete(:password_confirmation)
		end
		
		@user.save
		redirect_to index
	end
	
	def destroy
		@user.destroy!
		redirect_to index
	end
	
	private
	
	def get_user
		@user = User.find(params[:id])
	end
		
end

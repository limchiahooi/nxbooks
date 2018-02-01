class UsersController < ApplicationController
include SessionsHelper



	before_action :find_user, only: [:show, :edit, :update]

	def new
		@user = User.new
		render template: "users/new"
	end


	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			sign_in(@user)
			flash[:success] = "Welcome to Nvbooks!"
			redirect_to @user
		else
			# flash[:warning] = @user.errors.full_messages.first
			# redirect_to new_user_url

			respond_to do |format|
		        format.html { redirect_to new_user_path}
		        format.js { @user }
			end

		end
	end
	
	def show
		@listings = Listing.where(user_id: @user).order(id: :desc) 
	end
		

	def edit
		if current_user.id != @user.id
			flash[:warning] = "You are not allowed to edit this profile!"
			redirect_to @user			
		end			
	end

	def update
		if @user.update_attributes(user_params)
			flash[:info] = "Your profile has been successfully updated."
			redirect_to @user
		else
			flash[:warning] = "Please enter all fields marked with (*)."
			redirect_to edit_user_url
		end

	end



	

	

	private

	def find_user
		if @user = User.find_by(id: params[:id])
			return @user
		else
			flash[:warning] = "User does not exist."
			redirect_to "/"
		end
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :bio, :avatar, :remove_avatar)
	end






end

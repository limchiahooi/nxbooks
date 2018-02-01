class ListingsController < ApplicationController
include SessionsHelper


before_action :find_listing, only: [:show, :edit, :update, :destroy]

	def index
		@listings = Listing.all.order(id: :desc).paginate(:page => params[:page], :per_page => 8) 

	end


	def new
		@listing = Listing.new
		render "listings/new"
	end


	def create
		#use singular @listing coz only create one listing
		@listing = Listing.new(listing_params)
	    @listing.user_id = current_user.id if current_user
	     if @listing.save
	       redirect_to @listing
	     else
	        redirect_to new_listing_url
	     end
	end
	
	def show
		@comments = @listing.comments.order(id: :desc)
		@comment = Comment.new
		render "listings/show"
		
	end
		

	def edit
		if current_user.id != @listing.user_id
			flash[:warning] = "You are not allowed to edit this review!"
			redirect_to @listing			
		end			
	end

	def update
		if @listing.update_attributes(listing_params)
			flash[:info] = "Your review has been successfully updated."
			redirect_to @listing
		else
			flash[:warning] = "Please enter all fields marked with (*)."
			redirect_to edit_listing_url
		end

	end


	def destroy
		@listing.destroy
		redirect_to root_url
	end


	def search
		@search = Listing.all.order(id: :desc).paginate(:page => params[:page], :per_page => 4) 
	    @search = @search.where(["title ilike ?","%#{params[:search]}%"]).order(id: :desc).paginate(:page => params[:page], :per_page => 4)  if params[:search].present?
	    @search = @search.where(["author ilike ?","%#{params[:author]}%"]).order(id: :desc).paginate(:page => params[:page], :per_page => 4)  if params[:author].present?
	    @search = @search.where(["publisher ilike ?","%#{params[:publisher]}%"]).order(id: :desc).paginate(:page => params[:page], :per_page => 4)  if params[:publisher].present?
		@search = @search.where(["review ilike ?","%#{params[:review]}%"]).order(id: :desc).paginate(:page => params[:page], :per_page => 4)  if params[:review].present?
	end



	

	

	private

	def find_listing
		if @listing = Listing.find_by(id: params[:id])
			return @listing
		else
			flash[:warning] = "Review does not exist."
			redirect_to "/"
		end
	end

	def listing_params
		params.require(:listing).permit(:title, :author, :publisher, :review, {image: []}, :remove_image)
	end







end

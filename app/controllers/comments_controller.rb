class CommentsController < ApplicationController
	
	include SessionsHelper

	before_action :find_comment, only: [:show, :edit, :update, :destroy]


	def index
		@comments = Comment.all.order(id: :desc).paginate(:page => params[:page], :per_page => 20) 

	end


	def new
		@comment = Comment.new
		@listing = Listing.find(params[:listing_id])
		render "comments/new"
	end


	def create
		#use singular @listing coz only create one listing
		@listing = Listing.find(params[:listing_id])
		@comment = Comment.new(comment_params)
	    @comment.user_id = current_user.id if current_user
	    @comment.listing = @listing
	     
	     if @comment.save
	     	# redirect_to @listing
	     	respond_to do |format|
		        format.html { redirect_to @listing }
		        format.js
		    end
	     else
	     	flash[:warning] = "Error posting comment!"
	        redirect_to @listing
	     end
	end


	def destroy
		@comment = Comment.find(params[:id])
		@listing = Listing.find_by(id: @comment.listing_id)
		@comment.destroy
		# redirect_to @listing
		respond_to do |format|
		        format.html { redirect_to @listing }
		        format.js
		end

	end


	private

	def find_comment
		@comment = Comment.find(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:content)
	end


	
end

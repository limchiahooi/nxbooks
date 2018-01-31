class CommentsController < ApplicationController
include SessionsHelper

before_action :find_comment, only: [:show, :edit, :update, :destroy]


def index
		@comments = Comment.all.order(id: :desc).paginate(:page => params[:page], :per_page => 20) 

	end


	def new
		@comment = Comment.new
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





	
end

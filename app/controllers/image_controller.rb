class ImageController < ApplicationController

	before_action :find_listing

  def create
    add_more_images(images_params[:image])
    flash[:error] = "Failed uploading photos" unless @listing.save
    redirect_to @listing
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting photo" unless @listing.save
    redirect_to @listing
  end

  private

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

  def add_more_images(new_images)
    images = @listing.image 
    images += new_images
    @listing.image = images
  end

  def remove_image_at_index(index)
    remain_images = @listing.image # copy the array
    deleted_image = remain_images.delete_at(index) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @listing.image = remain_images # re-assign back
    @listing.remove_image! if remain_images.empty?
  end

  def images_params
    params.require(:listing).permit({image: []}) # allow nested params as array
  end

end

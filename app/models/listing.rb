class Listing < ApplicationRecord

	validates :title, presence: true


	
	belongs_to :user
	has_many :comments, dependent: :destroy
	

	mount_uploaders :image, ImageUploader







end

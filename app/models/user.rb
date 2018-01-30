class User < ApplicationRecord

  has_secure_password

  enum role: [:user, :admin]
  # same as enum verification: { user: 0, admin: 1 }

  mount_uploader :avatar, AvatarUploader


  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: 6..20, on: :create


  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :comments, dependent: :destroy


  def self.create_with_auth_and_hash(authentication,auth_hash)
      user = self.create! do |u|
      	u.name = auth_hash["extra"]["raw_info"]["name"]
      	u.password = SecureRandom.hex(10)
        u.email = auth_hash["extra"]["raw_info"]["email"] || "#{SecureRandom.hex(8)}@facebnb.com"
      end
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
      def fb_token
       x = self.authentications.where(:provider => :facebook).first
       return x.token unless x.nil?
      end

      def google_token
        x = self.authentications.find_by(:provider => 'google')
        return x.token unless x.nil?
      end


end

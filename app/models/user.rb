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


end

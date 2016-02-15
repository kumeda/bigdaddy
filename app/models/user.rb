class User < ActiveRecord::Base

  has_many :reports
  belongs_to :city

  authenticates_with_sorcery!

  mount_uploader :icon_image, ImageUploader
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
end

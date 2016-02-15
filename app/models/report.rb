class Report < ActiveRecord::Base

  belongs_to :user
  belongs_to :spot

  mount_uploader :image, ImageUploader

end
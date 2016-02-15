class Spot < ActiveRecord::Base

  has_many :users, dependent: :destroy
  belongs_to :city

end

class Zip < ActiveRecord::Base
  belongs_to :city

  validates :city, presence: true
  validates :code, presence: true, uniqueness: {case_sensitive: false}
end

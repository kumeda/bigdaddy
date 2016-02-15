class City < ActiveRecord::Base
  has_many :spots
  has_many :zips
  has_many :users
  belongs_to :county

  validates :county, presence: true
  validates :name,   presence: true, uniqueness: {case_sensitive: false, scope: :county_id}
end

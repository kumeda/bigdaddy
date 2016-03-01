# == Schema Information
#
# Table name: spots
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  yelp_url         :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  latitude         :float            not null
#  longitude        :float            not null
#  display_address  :string           not null
#  yelp_business_id :string           not null
#  city_id          :integer
#  yelp_image_url   :string           not null
#

class Spot < ActiveRecord::Base

  ### relation
  belongs_to :city
  has_many :reports

  ### before ###


  ### verify ###

  ## required
  validates_presence_of :name,
                        :yelp_url,
                        :latitude,
                        :longitude,
                        :display_address,
                        :yelp_business_id,
                        :yelp_image_url

  ## insert yelp data directly, so i don't verify the data.
  ## digits
  # string

  # integer

  ## uniqueness
  validates_uniqueness_of :yelp_business_id

  ## format


  ## other


  ### add properties ###


end

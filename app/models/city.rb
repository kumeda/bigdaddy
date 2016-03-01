# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  county_id  :integer
#

class City < ActiveRecord::Base

  include RegexDefinition

  ### relation
  has_many :spots
  has_many :zips
  has_many :users
  belongs_to :county

  ### before ###


  ### verify ###

  ## required
  validates_presence_of :name

  ## digits
  # string
  validates_length_of :name, maximum: 255

  # integer

  ## uniqueness
  validates_uniqueness_of :name, {scope: :county_id}

  ## format
  validates_format_of :name, with: REG_ALPHA, allow_blank: true, allow_nil: true

  ## other


  ### add properties ###

end
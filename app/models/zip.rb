# == Schema Information
#
# Table name: zips
#
#  id         :integer          not null, primary key
#  code       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#

class Zip < ActiveRecord::Base

  include RegexDefinition

  ### relation
  belongs_to :city


  ### before ###


  ### verify ###

  ## required
  validates_presence_of :code


  ## digits
  # string

  # integer
  validates_length_of :code, minimum: 3, maximum: 5, allow_blank: true, allow_nil: true

  ## uniqueness
  validates_uniqueness_of :code

  ## format
  validates_format_of :code, with: REG_NUM, allow_blank: true, allow_nil: true

  ## other


  ### add properties ###

end

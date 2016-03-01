# == Schema Information
#
# Table name: states
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  two_digit_code :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class State < ActiveRecord::Base

  include RegexDefinition

  ### relation
  has_many :counties

  ### before ###


  ### verify ###

  ## required
  validates_presence_of :name,
                        :two_digit_code

  ## digits
  # string
  validates_length_of :name, maximum: 255
  validates_length_of :two_digit_code, is: 2, allow_blank: true, allow_nil: true

  # integer

  ## uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :two_digit_code

  ## format
  validates_format_of :name, with: REG_ALPHA, allow_blank: true, allow_nil: true
  validates_format_of :two_digit_code, with: REG_ALPHA, allow_blank: true, allow_nil: true

  ## other


  ### add properties ###

end

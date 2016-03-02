# == Schema Information
#
# Table name: counties
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state_id   :integer
#

class County < ActiveRecord::Base

  include RegexDefinition

  ### relation
  belongs_to :state
  has_many   :cities

  ### before ###


  ### verify ###

  ## required
  validates_presence_of :name,
                        :state

  ## digits
  # string
  validates_length_of :name, maximum: 255

  # integer


  ## uniqueness
  validates_uniqueness_of :name, {scope: :state_id}

  ## format
  validates_format_of :name, with: REG_ALPHA, allow_blank: true, allow_nil: true

  ## other


  ### add properties ###


end

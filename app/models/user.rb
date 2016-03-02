# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string           not null
#  description                  :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  icon_image                   :string
#  email                        :string           not null
#  crypted_password             :string
#  salt                         :string
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  city_id                      :integer
#

class User < ActiveRecord::Base

  include RegexDefinition

  ### relation
  has_many :reports
  belongs_to :city

  mount_uploader :icon_image, ImageUploader


  ### before ###
  before_validation do
    self.email_for_index = email.downcase if email
  end


  ### verify ###

  ## required
  validates_presence_of :name,
                        :email,
                        :city

  ## digits
  # string
  validates_length_of :name, maximum: 255
  validates_length_of :description, maximum: 10000
  validates_length_of :password, minimum: 6, allow_blank: true, allow_nil: true, :on => :create_pw

  # integer

  ## uniqueness
  validates_uniqueness_of :email_for_index

  ## format
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create_pw
  validates_format_of :email, with: REG_EMAIL, allow_blank: true, allow_nil: true
  validates_format_of :password, with: REG_HANKAKU_EISU_WITH_ALL_MARK_WITHOUT_SPACE, allow_blank: true, allow_nil: true, :on => :create_pw

  ## other


  ### add properties ###

  authenticates_with_sorcery!

  def icon_image_url
    if self.icon_image.url
      return self.icon_image.user.url
    else
      return '/images/no_image_user.png'
    end
  end

end

# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string           not null
#  title                        :string
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
                        :email

  ## digits
  # string
  validates_length_of :name, maximum: 255
  validates_length_of :title, maximum: 255
  validates_length_of :description, maximum: 10000

  # integer

  ## uniqueness
  validates_uniqueness_of :email_for_index

  ## format
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_format_of :email, with: REG_EMAIL, allow_blank: true, allow_nil: true

  ## other


  ### add properties ###

  authenticates_with_sorcery!

  def self.update_except_for_image_path(user_params)
    User.where(@user).update_all(name: user_params[:name], description: user_params[:description], email: user_params[:email], city_id: user_params[:city])
  end

  def icon_image_url
    if self.icon_image.url
      return self.icon_image.user.url
    else
      return '/images/no_image_user.png'
    end
  end

end

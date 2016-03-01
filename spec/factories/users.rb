# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string           not null
#  description                  :string           not null
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

FactoryGirl.define do
  factory :user do
    
  end
end

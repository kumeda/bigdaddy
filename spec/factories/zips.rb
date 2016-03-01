# == Schema Information
#
# Table name: zips
#
#  id         :integer          not null, primary key
#  code       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#  spot_id    :integer
#

FactoryGirl.define do
  factory :zip do
    
  end
end

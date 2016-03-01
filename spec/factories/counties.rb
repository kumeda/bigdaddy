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

FactoryGirl.define do
  factory :county do
    
  end
end

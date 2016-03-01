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

FactoryGirl.define do
  factory :state do
    
  end
end

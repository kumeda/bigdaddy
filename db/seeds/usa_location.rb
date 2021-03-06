require 'csv'

puts "Loading States..."
CSV.foreach("#{Rails.root}/db/states.csv") do |row|
  state_code = row[0]
  state_name = row[1]
  State.create_with(name: state_name).find_or_create_by!(two_digit_code: state_code)
end
puts "...end of loading States"

puts "Loading Counties..."
CSV.foreach("#{Rails.root}/db/counties.csv") do |row|
  state_code  = row[0]
  county_name = row[1]
  County.find_or_create_by!(state_id: State.find_by_two_digit_code(state_code).id, name: county_name)
end
puts "...end of loading Counties"

puts "Loading Cities..."
CSV.foreach("#{Rails.root}/db/cities.csv") do |row|
  state_two_digit_code = row[0]
  state_id = State.find_by_two_digit_code!(state_two_digit_code).id

  county_name = row[1]
  city_name   = row[2]
  county      = County.find_by_state_id_and_name!(state_id, county_name)
  City.find_or_create_by!(county_id: county.id, name: city_name)
end
puts "...end of loading Cities"

puts "Loading Zips..."
CSV.foreach "#{Rails.root}/db/zips.csv" do |row|
  zip_code  = row[0]
  city      = row[1]
  county    = row[2]
  state     = row[3]
  state_id  = State.find_by_two_digit_code!(state).id
  county_id = County.find_by_name_and_state_id!(county, state_id).id
  Zip.create_with(city_id: City.find_by_name_and_county_id!(city, county_id).id).find_or_create_by!(code: zip_code)
end
puts "...end of loading Zips"
class SupportController < ApplicationController

  def search_yelp
    q = params['input']
    location_param = params['location'].split(',')[0]
    location = City.exists?(name: location_param) ? location_param : 'Mountain View'

    params = {
        'term' => q,
        'limit' => 10
    }

    client = get_yelp_client
    response = client.search(location, params)
    spots = response.businesses
    res = []
    for spot in spots do
      spot_info = {
          :id => spot.id,
          :display => "#{spot.name} (#{spot.location.city})"
      }
      res.push(spot_info)
    end

    render json: res
  end

  def search_city
    q = params['input']
    cities = City.where("name like '%" + q + "%'").limit(10)
    res = []
    for city in cities do
      city_info = {
          :id => city.id,
          :display => "#{city.name}, #{city.county.state.two_digit_code}"
      }
      res.push(city_info)
    end

    render json: res
  end

end
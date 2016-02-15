json.array!(@spots) do |spot|
  json.extract! spot, :id, :name, :yelp_url
  json.url spot_url(spot, format: :json)
end

json.array!(@historical_locations) do |historical_location|
  json.extract! historical_location, :id, :name, :lat, :lon
  json.url historical_location_url(historical_location, format: :json)
end

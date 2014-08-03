json.array!(@maps) do |map|
  json.extract! map, :id, :name, :center_lat, :center_lon, :zoom
  json.url map_url(map, format: :json)
end

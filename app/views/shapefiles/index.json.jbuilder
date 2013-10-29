json.array!(@shapefiles) do |shapefile|
  json.extract! shapefile, :name, :description, :shapefile
  json.url shapefile_url(shapefile, format: :json)
end

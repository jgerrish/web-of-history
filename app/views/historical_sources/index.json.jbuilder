json.array!(@historical_sources) do |historical_source|
  json.extract! historical_source, :name, :subject
  json.url historical_source_url(historical_source, format: :json)
end

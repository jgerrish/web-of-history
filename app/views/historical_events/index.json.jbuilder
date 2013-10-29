json.array!(@historical_events) do |historical_event|
  json.extract! historical_event, :historical_source_id, :title, :date_precision, :event_start_date, :event_end_date, :description, :lat, :lon
  json.url historical_event_url(historical_event, format: :json)
end

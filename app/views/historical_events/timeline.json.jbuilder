json.timeline do
  json.headline "Web of History"
  json.type "default"
  json.text "Browse through History"
  json.date do
    json.array!(@historical_events) do |historical_event|
      #json.extract! historical_event, :historical_source_id, :lat, :lon
      json.headline historical_event.title
      json.text historical_event.description
      json.startDate historical_event.event_start_date.try(:as_timelinejs_date)
      json.endate historical_event.event_end_date.try(:as_timelinejs_date)

      json.url historical_event_url(historical_event, format: :json)
    end
  end
end

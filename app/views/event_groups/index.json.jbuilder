json.array!(@event_groups) do |event_group|
  json.extract! event_group, :id, :name
  json.url event_group_url(event_group, format: :json)
end

class HistoricalLocation < ActiveRecord::Base
  has_many :historical_events_historical_locations
  has_many :historical_events,
  through: :historical_events_historical_locations

end

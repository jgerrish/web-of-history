class HistoricalEventsHistoricalLocation < ActiveRecord::Base
  belongs_to :historical_event
  belongs_to :historical_location
end

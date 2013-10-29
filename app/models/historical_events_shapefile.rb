class HistoricalEventsShapefile < ActiveRecord::Base
  belongs_to :historical_event
  belongs_to :shapefile
end

class EventGroupsHistoricalEvent < ActiveRecord::Base
  belongs_to :event_group
  belongs_to :historical_event
end

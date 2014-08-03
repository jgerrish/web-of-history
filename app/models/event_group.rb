class EventGroup < ActiveRecord::Base
  has_many :event_groups_maps
  has_many :maps, through: :event_groups_maps

  has_many :event_groups_shapefiles
  has_many :shapefiles, through: :event_groups_shapefiles

  has_many :event_groups_historical_events
  has_many :historical_events, through: :event_groups_historical_events

  accepts_nested_attributes_for :maps, :allow_destroy => true
  accepts_nested_attributes_for :shapefiles, :allow_destroy => true
  accepts_nested_attributes_for :historical_events, :allow_destroy => true
end

class HistoricalEvent < ActiveRecord::Base
  belongs_to :historical_source

  has_many :historical_events_shapefiles
  has_many :shapefiles, through: :historical_events_shapefiles

  has_many :historical_events_historical_locations
  has_many :historical_locations,
           through: :historical_events_historical_locations

  has_many :event_groups_historical_events
  has_many :event_groups, through: :event_groups_historical_events

  accepts_nested_attributes_for :shapefiles, :allow_destroy => true
  accepts_nested_attributes_for :historical_locations, :allow_destroy => true
  accepts_nested_attributes_for :event_groups, :allow_destroy => true

  #def as_json(opts={})
  #  as_json(include: shapefiles)
  #end

end

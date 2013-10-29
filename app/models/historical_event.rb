class HistoricalEvent < ActiveRecord::Base
  belongs_to :historical_source

  has_many :historical_events_shapefiles
  has_many :shapefiles, through: :historical_events_shapefiles

  accepts_nested_attributes_for :shapefiles, :allow_destroy => true

  #def as_json(opts={})
  #  as_json(include: shapefiles)
  #end

end

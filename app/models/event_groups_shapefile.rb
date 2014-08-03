class EventGroupsShapefile < ActiveRecord::Base
  belongs_to :event_group
  belongs_to :shapefile
end

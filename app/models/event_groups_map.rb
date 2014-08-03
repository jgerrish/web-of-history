class EventGroupsMap < ActiveRecord::Base
  belongs_to :event_group
  belongs_to :map
end

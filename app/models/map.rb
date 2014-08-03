class Map < ActiveRecord::Base
  has_many :event_groups_maps
  has_many :event_groups, through: :event_groups_maps

  accepts_nested_attributes_for :event_groups, :allow_destroy => true
end

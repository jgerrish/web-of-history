class CreateHistoricalEventsHistoricalLocations < ActiveRecord::Migration
  def change
    create_table :historical_events_historical_locations do |t|
      t.references :historical_event,    :null => false
      t.references :historical_location, :null => false

      t.timestamps
    end

    add_index :historical_events_historical_locations, :historical_event_id, :name => :hehl_historical_event_id
    add_index :historical_events_historical_locations, :historical_location_id, :name => :hehl_historical_location_id
    add_index :historical_events_historical_locations, [:historical_event_id, :historical_location_id], :name => :hehl_hehl_id, :unique => true
  end
end

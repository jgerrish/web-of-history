class CreateHistoricalEventsShapefiles < ActiveRecord::Migration
  def change
    create_table :historical_events_shapefiles do |t|
      t.references :historical_event, index: true
      t.references :shapefile, index: true

      t.timestamps
    end
  end
end

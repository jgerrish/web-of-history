class CreateHistoricalEvents < ActiveRecord::Migration
  def change
    create_table :historical_events do |t|
      t.references :historical_source, index: true
      t.string :title
      t.string :date_precision
      t.date :event_start_date
      t.date :event_end_date
      t.text :description
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end

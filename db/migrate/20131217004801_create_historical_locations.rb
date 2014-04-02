class CreateHistoricalLocations < ActiveRecord::Migration
  def change
    create_table :historical_locations do |t|
      t.string :name, :null => false, :index => true
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end

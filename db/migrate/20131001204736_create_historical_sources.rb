class CreateHistoricalSources < ActiveRecord::Migration
  def change
    create_table :historical_sources do |t|
      t.string :name
      t.string :subject

      t.timestamps
    end
  end
end

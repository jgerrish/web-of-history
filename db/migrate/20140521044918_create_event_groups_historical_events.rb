class CreateEventGroupsHistoricalEvents < ActiveRecord::Migration
  def change
    create_table :event_groups_historical_events do |t|
      t.references :event_group, index: true
      t.references :historical_event, index: true

      t.timestamps
    end

    add_index :event_groups_historical_events, [:event_group_id, :historical_event_id], :name => :eghe_eghe_id, :unique => true
  end
end

class CreateEventGroupsMaps < ActiveRecord::Migration
  def change
    create_table :event_groups_maps do |t|
      t.references :event_group, index: true
      t.references :map, index: true

      t.timestamps
    end

    add_index :event_groups_maps, [:event_group_id, :map_id], :name => :egm_egm_id, :unique => true
  end
end

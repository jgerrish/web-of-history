class CreateEventGroupsShapefiles < ActiveRecord::Migration
  def change
    create_table :event_groups_shapefiles do |t|
      t.references :event_group, index: true
      t.references :shapefile, index: true

      t.timestamps
    end

    add_index :event_groups_shapefiles, [:event_group_id, :shapefile_id], :name => :egs_egs_id, :unique => true
  end
end

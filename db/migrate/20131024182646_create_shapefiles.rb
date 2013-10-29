class CreateShapefiles < ActiveRecord::Migration
  def change
    create_table :shapefiles do |t|
      t.string :name
      t.text :description
      t.string :shapefile
      t.string :shapefile_type

      t.timestamps
    end
  end
end

class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name,       :null => false
      t.float :center_lat
      t.float :center_lon
      t.float :zoom

      t.timestamps
    end

    add_index :maps, :name, :unique => true
  end
end

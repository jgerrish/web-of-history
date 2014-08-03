class CreateEventGroups < ActiveRecord::Migration
  def change
    create_table :event_groups do |t|
      t.string :name,               :null => false

      t.timestamps
    end

    add_index :event_groups, :name, :unique => true
  end
end

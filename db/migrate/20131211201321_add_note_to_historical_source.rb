class AddNoteToHistoricalSource < ActiveRecord::Migration
  def change
    add_column :historical_sources, :note, :text
  end
end

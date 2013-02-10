class CreateRecordedPositions < ActiveRecord::Migration
  def change
    create_table :recorded_positions do |t|
      t.integer :bus_route_id
      t.point :location
      t.integer :bus_id
      t.string :direction
      t.integer :block_id
      t.string :destination
      t.timestamp :reported_at

      t.timestamps
    end
  end
end

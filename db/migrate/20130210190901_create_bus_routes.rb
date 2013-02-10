class CreateBusRoutes < ActiveRecord::Migration
  def change
    create_table :bus_routes do |t|
      t.string :name
      t.column :route_outline, :polygon, :geometric=>true

      t.timestamps
    end
    add_index :bus_routes, :name, :unique=>true
  end
end

require "no_rails_spec_helper"
require "bus_route_importer"
require "rgeo"
describe BusRouteImporter do

  it "creates a bus route for each route" do
    bus_route_creator.should_receive(:create!).twice
    BusRouteImporter.new(gtfs_source, bus_route_creator).import!
  end

  it "creates a polygon with the righ points" do
    bus_route_importer.factory.should_receive(:multi_line_string)
    bus_route_importer.import_route!(route_1)
  end

  let(:bus_route_importer){BusRouteImporter.new(gtfs_source, bus_route_creator)}

  let(:gtfs_source) {stub(routes: [route_1, route_2], 
                          trips: [trip_1, trip_2, trip_3],
                          shapes: shapes)}
  let(:route_1){stub(short_name: "12", id: 1234)}
  let(:route_2){stub(short_name: "17", id: 1235)}
  let(:trip_1){stub(route_id: 1234, shape_id: 111)}
  let(:trip_2){stub(route_id: 1234, shape_id: 222)}
  let(:trip_3){stub(route_id: 1235, shape_id: 333)}
  let(:shapes){[shape("-1","1",111), shape("1","1",111),
                shape("1", "2",222), shape("2","2",222)]}
  let(:bus_route_creator){stub(create!: true)}

  def shape(lon,lat,id) 
    stub(pt_lon: lon, pt_lat: lat, id: id)
  end
end

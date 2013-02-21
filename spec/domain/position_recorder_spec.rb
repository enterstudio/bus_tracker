require "no_rails_spec_helper"
require "position_recorder" 
require "rgeo"

describe PositionRecorder do

  context "storing from hash" do

    it "creates the record" do
      position_creator.should_receive(:create!).with(
        bus_route: route,
        vehicle_id: "8077",
        block_id: "7260",
        location: an_instance_of(RGeo::Geos::CAPIPointImpl),
        direction: "WestBound",
        destination: "50th - Woodland",
        recorded_at: an_instance_of(Time))
      recorder.record_position!(position_hash) 
    end

    let(:route) {stub("route")}
    let(:position_creator) {stub("creator", :create! => true)}
    let(:recorder) {PositionRecorder.new(route, position_creator)}
    let(:position_hash) {{"lat"=>"39.950916", "lng"=>"-75.175949", "label"=>"8077", "VehicleID"=>"8077", "BlockID"=>"7260", "Direction"=>"WestBound", "destination"=>"50th - Woodland", "Offset"=>"1"}}
  end
end

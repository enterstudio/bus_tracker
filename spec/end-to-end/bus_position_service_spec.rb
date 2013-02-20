require "spec_helper"

describe BusPositionService do
  it "has a method to create for a route" do
    BusPositionService.create_for_route(bus_route)
  end

  it "records positions for a route" do
    bus_route
    VCR.use_cassette('json_fetcher.septa') do
      BusPositionService.fetch_and_record_positions_for_route_name("12")
    end
    RecordedPosition.count.should == 1
  end

  let(:bus_route){BusRoute.create(:name=>"12")}
end

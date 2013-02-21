require "no_rails_spec_helper"
require "bus_position_fetcher"

describe BusPositionFetcher do
  context "fetches a hash" do
    let(:a_sample_response) {
      {"bus"=>[{"lat"=>"39.950916", "lng"=>"-75.175949", "label"=>"8077", "VehicleID"=>"8077", "BlockID"=>"7260", "Direction"=>"WestBound", "destination"=>"50th - Woodland", "Offset"=>"1"}, {"lat"=>"39.940273", "lng"=>"-75.213531", "label"=>"8436", "VehicleID"=>"8436", "BlockID"=>"7261", "Direction"=>"WestBound", "destination"=>"50th - Woodland", "Offset"=>"1"}]}
    }
    
    let(:url_fetcher){ stub(hash_for_url: a_sample_response)}
    let(:bus_route){ stub(name: "12")}
    let(:position_fetcher) {BusPositionFetcher.new(bus_route, url_fetcher)}

    it "fetches an array of positions" do
      position_fetcher.fetch_positions_as_hashes.should be_an_instance_of(Array)
    end

    it "has the right size" do
      position_fetcher.fetch_positions_as_hashes.size.should == 2
    end

    it "fetches the url" do
      url_fetcher.should_receive(:hash_for_url).with("http://www3.septa.org/transitview/bus_route_data/12") 
      position_fetcher.fetch_positions_as_hashes
    end
  end
end

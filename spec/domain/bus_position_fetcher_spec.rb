require "no_rails_spec_helper"
require "bus_position_fetcher"

describe BusPositionFetcher do
  context "fetches a hash" do
    Given(:a_sample_response) {
      response = <<-RESPONSE
      {"bus": [{"lat":"39.950916","lng":"-75.175949","label":"8077","VehicleID":"8077","BlockID":"7260","Direction":"WestBound","destination":"50th - Woodland","Offset":"1"},{"lat":"39.940273","lng":"-75.213531","label":"8436","VehicleID":"8436","BlockID":"7261","Direction":"WestBound","destination":"50th - Woodland","Offset":"1"}] }
      RESPONSE
    }
    
    Given(:url_fetcher){ flexmock(hash_for_url: a_sample_response)}
    Given(:bus_route){ flexmock(name: "12")}
    Given(:position_fetcher) {BusPositionFetcher.new(bus_route, url_fetcher)}
    When(:result) { position_fetcher.fetch_positions_as_hashes }
    Then { result.should be_an_instance_of Array }
    And { result.size.should == 2 }
    And { url_fetcher.should have_received(:hash_for_url).with("http://www3.septa.org/transitview/bus_route_data/12") }

  end
end

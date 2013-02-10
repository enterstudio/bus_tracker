require "no_rails_spec_helper"
require "json"
require "json_fetcher"

describe JSONFetcher do
  context "Fetching JSON from URL" do

    Given(:fetcher) {JSONFetcher.new}
    Given(:test_url) {"http://www3.septa.org/transitview/bus_route_data/12"}
    When(:result) do
      VCR.use_cassette('json_fetcher.septa') do
      response = fetcher.hash_for_url(test_url)
      end
    end

    Then { result.should be_an_instance_of Hash}
    And {result["bus"].should have(1).record}
  end
end

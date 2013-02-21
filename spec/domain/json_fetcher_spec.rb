require "no_rails_spec_helper"
require "json"
require "json_fetcher"

describe JSONFetcher do
  context "Fetching JSON from URL" do

    it "Fetches the json from the url" do
      VCR.use_cassette('json_fetcher.septa') do
        fetcher.hash_for_url(test_url)["bus"].should have(1).record
      end
    end

    let(:fetcher) {JSONFetcher.new}
    let(:test_url) {"http://www3.septa.org/transitview/bus_route_data/12"}
  end
end

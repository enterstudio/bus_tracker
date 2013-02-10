class BusPositionFetcher

  def initialize(bus_route, json_fetcher)
    @bus_route = bus_route
    @json_fetcher = json_fetcher
  end

  def fetch_positions_as_hashes
    @json_fetcher.hash_for_url(route_url)["bus"]
  end

protected

  def route_url
    "http://www3.septa.org/transitview/bus_route_data/#{@bus_route.name}"
  end
end

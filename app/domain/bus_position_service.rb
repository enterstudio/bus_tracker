class BusPositionService

  def initialize(position_fetcher, position_recorder)
    @position_fetcher = position_fetcher
    @position_recorder = position_recorder
  end

  def self.create_for_route(bus_route)
    new(BusPositionFetcher.new(bus_route,JSONFetcher.new),
        PositionRecorder.new(bus_route, RecordedPosition))
  end

  def self.fetch_and_record_positions_for_route_name(route_name)
    route = BusRoute.named(route_name)
    create_for_route(route).fetch_and_record_positions!
  end

  def fetch_and_record_positions!
    @position_fetcher.fetch_positions_as_hashes.map do |position_hash|
      @position_recorder.record_position!(position_hash)
    end
  end

end

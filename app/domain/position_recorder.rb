class PositionRecorder
  def initialize(bus_route, recorded_position_creator)
    @bus_route = bus_route
    @recorded_position_creator = recorded_position_creator
  end

  def record_position!(hash)
    @recorded_position_creator.create!( bus_route: @bus_route,
                                        vehicle_id: hash["VehicleID"],
                                        block_id: hash["BlockID"],
                                        destination: hash["destination"],
                                        direction: hash["Direction"],
                                        recorded_at: recorded_time(hash["Offset"]),
                                        location:  location(hash["lng"],hash["lat"])
                                      )

  end

  def recorded_time(minutes_ago_string)
    Time.now - (minutes_ago_string.to_i * 60)
  end

  def location(lng, lat)
    RGeo::Geos.factory.point(lng.to_f, lat.to_f)
  end
end

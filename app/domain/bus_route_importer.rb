class BusRouteImporter
  def initialize(gtfs_source, bus_route_creator)
    @gtfs_source = gtfs_source
    @bus_route_creator = bus_route_creator
  end

  def import!
    @gtfs_source.routes.each do |route|
      import_route!(route)
    end
  end

  def import_route!(route)
    @bus_route_creator.create!(name: route.short_name, 
                               route_outline: factory.multi_line_string(lines_for_route(route)))
  end

  def lines_for_route(route)
    puts "Finding lines for route: #{route.short_name}"
    shape_ids_for_route(route).map do |shape_id|
      line_for_shape_id(shape_id)
    end
  end

  def shape_ids_for_route(route)
    @gtfs_source.trips.select {|t| t.route_id == route.id}.map(&:shape_id).uniq
  end

  def line_for_shape_id(shape_id)
    puts "finding lines for shape id: #{shape_id}"
    factory.line_string(points_for_shape_id(shape_id))
  end

  def points_for_shape_id(shape_id)
    @gtfs_source.shapes.select {|s| s.id == shape_id}.map do |point|
      factory.point(point.pt_lon.to_f, point.pt_lat.to_f)
    end
  end

  def factory
    @factory ||= RGeo::Geographic.spherical_factory
  end

end

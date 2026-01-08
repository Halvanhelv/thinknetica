class Route
  attr_accessor :stations
  def initialize(stations = [])
    if stations.size >= 2
      @stations = stations
      puts "Route #{@stations.first.name} - #{@stations.last.name} created"

    else
      puts 'There must be a starting and ending station!'
    end
  end

  def add_station(station, route)
    stations.insert(-2, station)
    puts   "Station #{station.name} added to route #{route} "
  end

  def remove_station(station)
    stations.delete(station)
    puts   "Station #{station.name} removed "
  end

  def list
    names = []
    stations.each do |index|
      names << index.name

    end
    names
  end


end

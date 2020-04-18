class Route
  attr_accessor :stations
  def initialize(stations = [])
    if stations.size >= 2
      @stations = stations
      puts "Маршрут #{@stations.first.name} - #{@stations.last.name} создан"

    else
      puts 'Должна быть начальная и конечная станция!'
    end
  end

  def add_station(station, route)
    stations.insert(-2, station)
    puts   "Станция #{station.name} добавлена в маршрут #{route} "
  end

  def remove_station(station)
    stations.delete(station)
    puts   "Станция #{station.name} удалена "
  end

  def list
    stations
  end


end

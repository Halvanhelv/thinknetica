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

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  def list
    stations
  end


end

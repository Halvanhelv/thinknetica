# frozen_string_literal: true

require_relative 'modules/instance_counter'
class Route
  include InstanceCounter
  attr_accessor :stations
  def initialize(stations = [])
    @stations = stations
    validate!
  end

  def validate!
    raise 'Станций должно быть минимум две' if @stations.size < 2

    raise '1 и 2 станции не разные' if @stations.first == @stations.last
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station, route)
    stations.insert(-2, station)
    puts "Станция #{station.name} добавлена в маршрут #{route} "
  end

  def remove_station(station)
    stations.delete(station)
    puts "Станция #{station.name} удалена "
  end

  def list
    stations.map(&:name)
  end
end

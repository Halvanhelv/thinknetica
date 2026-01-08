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
    raise 'There must be minimum two stations' if @stations.size < 2
    if @stations.first == @stations.last
      raise 'Starting and ending stations cannot be the same'
    end


  end
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
  def add_station(station, route)
    stations.insert(-2, station)
    puts "Station #{station.name} added to route #{route} "
  end

  def remove_station(station)
    stations.delete(station)
    puts "Station #{station.name} removed "
  end

  def list
    names = []
    names = stations.map(&:name)
  end


end

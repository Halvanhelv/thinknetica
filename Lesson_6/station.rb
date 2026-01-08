require_relative 'modules/instance_counter'
class Station
  include InstanceCounter
  attr_reader :name
  attr_accessor :trains
  @@stations = []
  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self

  end

  def self.all
    @@stations
  end
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
  def validate!
    raise 'Station has no name' unless @name
    raise 'Station name must have minimum 6 characters' if @name.length < 6

  end
  def add_train(train)
    @trains << train if train.route.stations.include?(self)

    puts "Train number #{train.number} arrived at station #{@name}"
  end

  def send_train(train)
    @trains.delete(train)

    puts "Train number #{train.number} departed from station #{@name}"
  end

  def train_type
    [@trains.count(&:cargo?), @trains.count(&:passenger?)]
  end
end

class Station
  attr_reader :name
  attr_accessor :trains
  def initialize(name)
    @name = name
    @trains = []
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

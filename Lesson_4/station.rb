class Station
  attr_reader :name
  attr_accessor :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train if train.route.stations.include?(self)

    puts "На  станцию #{@name} Прибыл поезд поезд под номером #{train.number}"
  end

  def send_train(train)
    @trains.delete(train)

    puts "Со станции #{@name} отправлен поезд под номером #{train.number}"
  end

  def train_type
    [@trains.count(&:cargo?), @trains.count(&:passenger?)]

  end

end
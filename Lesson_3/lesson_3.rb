class Station
  attr_reader :name, :train
  attr_accessor :train
  def initialize(name)
    @name = name
    @train = []
  end

  def add_train(train)
    @train << train
    puts "На  станцию #{@name} Прибыл поезд поезд под номером #{train.number}"
  end

  def send_train(train)
    @train.delete(train)

    puts "Со станции #{@name} отправлен поезд под номером #{train.number}"
  end

  def train_type
    cargo, passenger = [0, 0]
    @train.each do |train|
      cargo += 1 if train.type == "cargo"
      passenger += 1 if train.type == "passenger"
    end
    [cargo, passenger]
    end
  end

class Train
  attr_reader :type, :number, :count
end
def initialize(number, type, count)
  @number = number
  @type = type
  @count = count
end

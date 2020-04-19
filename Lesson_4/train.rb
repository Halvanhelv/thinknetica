class Train
  attr_reader :number, :type
  attr_accessor :speed, :route, :current, :train_type, :wagons
  def initialize(number)
    @speed = 0
    @number = number
    @wagons = []
  end
  def cargo?
    true if type == 'cargo'
  end

  def passenger?
    true if type == 'passenger'
  end

  def remove_wagon
    wagons.delete(-1) unless wagons.empty?
  end

  def add_wagon(wagon)
    if wagon.wagon_type == train_type
    wagons << wagon

    puts "Вагон #{wagon} прицеплен"
    else
      puts 'Приципите вагон правильного типа'
    end
  end

  def add_route(route)
    @route = route
    @current = route.stations.first
    route.stations.first.add_train(self)
    puts "Поезд №#{@number} готов ехать с станции #{@route.stations.first.name} на станцию #{@route.stations.last.name}"

  end

  def prev_station
    if @route
    if @current != @route.stations.first
      prev_step = @route.stations.index(@current) - 1
      @current = @route.stations[ prev_step]
      route.stations[prev_step].add_train(self)
    else
      puts 'Станция конечная'
    end
    else
      puts "У поезда нет маршрута"
    end
  end

  def next_station
    if @route
    if @current != @route.stations.last
      next_step = @route.stations.index(@current) + 1
      @current = @route.stations[next_step]
      route.stations[next_step].add_train(self)
    else
      puts 'Станция конечная'
    end
    else
      puts "У поезда нет маршрута"
    end
  end

  def add_speed(speed)
    self.speed += speed.to_i
  end

  def stop_train
    if self.speed <= 0
      puts 'Поезд уже остановлен'
    else
      self.speed = 0
      puts 'Поезд остановлен'
    end
  end
  end

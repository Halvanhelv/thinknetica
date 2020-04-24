require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require 'rouge'
class Main
  def initialize
    @trains = {}
    @stations = []
    @routes = {}
  end

  def go

    loop do
      go_menu
      case gets.chomp.to_i
      when 1 then trains_menu
      when 2 then station_menu
      when 3 then routes_menu
      when 4 then station_info
      else exit
      end

    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def go_menu
    puts 'Выберите действие'
    puts '1 Действие с поездами'
    puts '2 Действие со станциями'
    puts '3 Действие с  маршрутами'
    puts '4 Вся информация'
  end

  private

  def train_name(train)

    puts "Данный поезд принадлежит компании #{train.view_comp_name}"
  end

  def wagons_info(train)
    if train.is_a?(PassengerTrain)
      train.wagons_list do |_index, wagon|
        puts "#{wagon.number},  #{wagon.free_places} мест #{wagon.busy} мест"
      end
    elsif train.is_a?(CargoTrain)
      train.wagons_list do |_index, wagon|
        puts "#{wagon.number} #{wagon.free_capacity} #{wagon.busy_capacity}"
      end
    end
  end

  def station_info
    @stations.each do |station|
      station.trains_list do |train|
        puts "Поезд: #{train.number}, Тип: #{train.train_type}"
        puts 'Вагоны (номер, свобоно, занято):'
        wagons_info(train)

      end

    end
  end

  def add_name(train)
    puts 'Введите Название компании'
    name = gets.chomp.to_s
    train.add_name(name)
  end

  def next_station(train)
    train.next_station
  rescue RuntimeError => e
    puts e.message.to_s
  end

  def prev_station(train)

    train.prev_station
  rescue RuntimeError => e
    puts e.message.to_s

  end

  def stations_list
    if @stations.any?
      @stations.each_with_index do |value, index|
        puts "id = #{index} - #{value.name} на станции находятся поезда:
        #{value.trains}"
      end
    else
      puts 'Станций нет!'
    end
  end

  def remove_station(route)
    puts 'Выберите станцию'
    puts route.list

    stations_id = gets.chomp.to_i
    route.remove_station(@stations[stations_id])
  end

  def add_station(route)
    puts 'Выберите станцию'
    stations_list
    stations_id = gets.chomp.to_i
    route.add_station(@stations[stations_id], stations_id)

  end

  def create_route_input
    puts 'Введите id станций,минимум две станции через запятую'
    stations_list
    gets.chomp.split(',')
  end

  def create_route
    stations_ids = create_route_input
    names = []
    @stations.each_with_index do |value, index|
      stations_ids.each do |values|
        names << value if index == values.to_i
      end
    end
    stations_ids = stations_ids.join('')
    @routes[stations_ids] = Route.new(names)
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def route_menu(route)
    loop do
      puts "1 Добавить станцию в маршруте #{route} "
      puts "2 Удалить станцию в маршруте #{route} "
      case gets.chomp.to_i
      when 1 then add_station(route)
      when 2 then remove_station(route)
      else
        break
      end
    end
  end

  def routes_menu_puts
    puts 'Введите желаемое действие'
    puts '1 Создать маршрут'
    puts '2 Выбрать маршрут'
  end

  def pick_route
    if @routes.any?
      route_list
      route = gets.chomp.to_s
      route_menu(@routes[route])
    else
      'Маршрутов нет'
    end
  end

  def routes_menu
    raise 'Нужно минимум 2 станции ' unless @stations.count > 1

    loop do
      routes_menu_puts

      case gets.chomp.to_i
      when 1 then create_route
      when 2 then pick_route
      else
        break
      end
    end

  end

  def create_station
    begin
    puts 'Введите название станции'
    name = gets.chomp.to_s
    @stations << Station.new(name)

    rescue RuntimeError => e
      puts e.message.to_s
      retry
  end
    puts "Станция #{name} Создана"

  end

  def station_menu
    loop do
      puts '1 Cоздать станцию'
      puts '2 Список  станций'

      case gets.chomp.to_i
      when 1 then create_station
      when 2 then stations_list
      else
        break
      end
    end
  end

  def route_list
    @routes.each do |index, value|
      puts " id #{index} #{value.stations}"
    end
  end

  def add_route(train)
    puts "Выбран поезд #{train},введите номер маршрута"
    route_list
    route_name = gets.chomp.to_s
    raise 'Нет такого маршрута' unless @routes[route_name]

    route_value = @routes[route_name]
    @trains[train.number].add_route(route_value)
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def create_cargo_train
    puts 'Введите имя грузового  поезда'
    train_number = gets.chomp.to_s
    @trains[train_number] = CargoTrain.new(train_number)
    puts "Поезд #{train_number} Создан"
  end

  def create_passenger_train
    puts 'Введите имя пасажирского  поезда'
    train_number = gets.chomp.to_s
    @trains[train_number] = PassengerTrain.new(train_number)
    puts "Поезд #{train_number} Создан"
  end

  def trains_list
    @trains.each do |name, value|
      puts "Поезд номер = #{name} Тип #{value.train_type}"
    end
  end

  def create_train

    puts 'Какой поезд создать: 1 -- Грузовой, 2 -- Пасажирский'
    case gets.chomp.to_i
    when 1 then create_cargo_train
    when 2 then create_passenger_train

    else
      raise 'Есть только два вида поездов'
    end

  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def remove_wagons(train)
    train.remove_wagon
  end

  def add_wagons_menu(train)
    puts "Ваш поезд #{train.train_type} типа"
    puts 'Какой вагон Присоеденить'
    puts '1 - Пасажирский '
    puts '2 - Грузовой'
  end

  def add_wagons(train)

    add_wagons_menu(train)
    wagon_type = gets.chomp.to_i
    number = rand(100)
    wagon =
      if wagon_type == 1
        add_passenger_wagon(number)
      elsif wagon_type == 2
        add_cargo_wagon(number)
      else raise 'У вас есть выбор только из двух типов'
      end

    train.add_wagon(wagon, number.to_s)
  rescue RuntimeError => e
    puts e.message.to_s
    retry

  end

  def add_cargo_wagon(number)
    puts 'Введите объем  в вагоне'
    capacity = gets.chomp.to_i
    CargoWagon.new(capacity, number)
  end

  def add_passenger_wagon(number)
    puts 'Введите количество мест в вагоне'
    places = gets.chomp.to_i
    PassengerWagon.new(places, number)
  end

  def train_menu_puts(train)
    puts "Выбран поезд #{train.number}"
    puts '1 Добавить вагон'
    puts '2 Удалить вагон'
    puts '8 Выбрать вагон'
    puts '3 Добавить Маршрут'
    puts '4 Вперед по маршруту'
    puts '5 Назад по маршруту'
    puts '6 Назначить название компании изготовителя'
    puts '7 Имя производителя поезда'
  end

  def train_menu(train)
    raise 'Такого поезда не существует' unless @trains.value? train

    loop do
      train_menu_puts(train)
      act = gets.chomp.to_i
      case act
      when 1 then  add_wagons(train)
      when 2 then  remove_wagons(train)
      when 3 then add_route(train)
      when 4 then next_station(train)
      when 5 then prev_station(train)
      when 6 then add_name(train)
      when 7 then train_name(train)
      when 8 then pick_wagon(train)
      else
        break
      end

    end

  end

  def pick_wagon(train)
    puts 'Выберите вагон'
    train.wagons_list { |_index, value| puts value.number }
    wagon = train.pick_wagon(gets.chomp.to_s)
    if wagon.wagon_type == 'passenger'
      passenger_wagon_menu(wagon)
    else
      cargo_wagon_menu(wagon)
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def cargo_wagon_menu_puts
    puts '1 Заполнить вагон'
    puts '2 Свободный объем'
    puts '3 Занятый объем'
  end

  def cargo_wagon_menu(wagon)
    loop do
      cargo_wagon_menu_puts
      case gets.chomp.to_i
      when 1 then take_capacity(wagon)
      when 2 then wagon.busy_capacity
      when 3 then wagon.capacity
      else
        break
      end

    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def take_capacity(wagon)
    puts 'Введите объем'
    capacity = gets.chomp.to_i
    wagon.take_capacity(capacity)
  end

  def passenger_wagon_menu_puts
    puts '1 Занять 1  место в вагоне'
    puts '2 Количество занятых мест'
    puts '3 Количество свободных мест'
  end

  def passenger_wagon_menu(wagon)

    loop do
      passenger_wagon_menu_puts
      act = gets.chomp.to_i
      case act
      when 1 then take_place(wagon)
      else
        break
      end

    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def take_place(wagon)
    wagon.take_place
  end

  def trains_menu_puts
    puts '1 Выбрать поезд'
    puts '2 Создать поезд'
  end

  def trains_menu

    loop do
      trains_menu_puts
      case gets.chomp.to_i
      when 1
        if @trains.any?

          puts 'Выберите поезд'
          trains_list
          train = gets.chomp.to_s
          train_menu(@trains[train])

        else
          puts 'Поездов нет'

        end
      when 2
        create_train

      else
        break
      end
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end


end
Main.new.go



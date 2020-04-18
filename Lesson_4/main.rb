# frozen_string_literal: true
#
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
@trains = {}
@stations = []
@routes = {}

def next_station
  puts 'Выберите поезд'
  train = gets.chomp.to_i
  @trains[train].next_station
end
def prev_station
  puts 'Выберите поезд'
  train = gets.chomp.to_i
  @trains[train].prev_station
end
def add_wagon

  if @trains.any?
    puts 'Выберите вагон'
    puts '1 - Пасажирский '
    puts '2 - Грузовой'

    wagon_type =  gets.chomp.to_i

    if wagon_type == 1
      wagon = PassengerWagon.new
    elsif wagon_type == 2
    wagon = CargoWagon.new
    else
      puts 'Вы не выбрали тип вагона'
    end

    trains_list
    puts 'Выберите Поезд'
    train = gets.chomp.to_i
    @trains[train].add_wagon(wagon)
  else
    puts 'Для начала создайте поезд'
  end
  end
def remove_wagon

end
def add_station
  route_list
  puts 'Выберите маршрут куда нужно добавить станцию'
  route_id = gets.chomp.to_s
  puts 'Выберите станцию'
  stations_print
  stations_id = gets.chomp.to_i

  @routes[route_id].add_station(@stations[stations_id], route_id)

end
def trains_list
  @trains.each do |name,value|
    puts "Поезд номер = #{name}"

  end
end

def remove_station
  route_list
  puts 'Выберите маршрут откуда нужно удалить  станцию'
  route_id = gets.chomp.to_s
  puts 'Выберите станцию'
  stations_print
  stations_id = gets.chomp.to_i

  @routes[route_id].remove_station(@stations[stations_id])
end

def add_route
  if @routes.any?
    if @trains.any?
      puts 'Введите номер поезда'
      train_id = gets.chomp.to_i

      route_list
      puts 'Введите номер маршрута'

      route_name = gets.chomp.to_s
      route_name = @routes[route_name]
      train_id = @trains[train_id].add_route(route_name)

    else
      puts 'Нет поездов'
    end
  else
    puts 'Нет маршрутов'
  end
end

def route_list
  @routes.each do |index, value|
    puts " id #{index} #{value.list.first.name} --- #{value.list.last.name}"
  end
end

def stations_print
  @stations.each_with_index do |value, index|

    puts "id = #{index}  --- #{value.name} #{value.trains}"

  end
end

def create_station(name)
  @stations << Station.new(name)
  puts "Станция #{name} Создана"


end

def create_passenger_train(number)
  @trains[number] = PassengerTrain.new(number)
  puts "Поезд #{number} Создан"

end

def create_cargo_train(number)
  @trains[number] << CargoTrain.new(number)
  puts "Поезд #{number} Создан"

end

def create_route(station_ids)

  names = []


  @stations.each_with_index do |value , index|
    station_ids.each do |values|

      names << value if index == values.to_i


    end


  end
  station_ids = station_ids.join('')
  @routes[station_ids] = Route.new(names)



end

def route_menu
  if @stations.count > 1
  loop do

    puts 'Введите желаемое действие'
    puts '1 Создать маршрут'
    puts '2 Список маршрутов'
    puts '3 Добавить станцию в маршрут'
    puts '4 Удалить станцию из маршрута'
    id = gets.chomp.to_i




    case id
    when 1
      puts 'Введите id станций,минимум две станции через запятую'
      stations_print
      station_ids = gets.chomp.split(',')

      create_route(station_ids)

    when 2

      route_list
    when 3

      add_station
    when 4

      remove_station
    else
      break end
  end
  else
    puts 'Для создания маршрута нужно минимум две станции'
  end
end

def station_menu
  loop do

    puts 'Введите желаемое действие'
    puts '1 Создать станцию'
    puts '2 Список станция и поездов на них'

    id = gets.chomp.to_i
    case id
    when 1
      puts 'Введите имя станции'
      name = gets.chomp.to_s
      create_station(name)
    when 2


      stations_print
    else
      break
    end
  end
end

def train_menu
  loop do

  puts 'Введите желаемое действие'
  puts '1 Создать пасажирский поезд'
  puts '2 Создать грузовой поезд поезд'
  puts '3 Добавить маршрут поезду'
  puts '4 Добавить вагон'
  puts '5 Удалить вагон'
  puts '6 Отправить поезд на следующую станцию'
  puts '7 Отправить поезд на предыдущую  станцию'
  id = gets.chomp.to_i



  case id
  when 1
    puts 'Введите имя(номер) поезда'
    number = gets.chomp.to_i
    create_passenger_train(number)

  when 2
    puts 'Введите имя(номер) поезда'
    number = gets.chomp.to_i
    create_cargo_train(number)
  when 3
    add_route
  when 4
    add_wagon
  when 5
    remove_wagon
  when 6
    next_station
  when 7
    prev_station
  else
    break end
  end
  end
loop do
  puts 'Выберите действие'
  puts '1 Действие с поездами'
  puts '2 Действие со станциями'
  puts '3 Действие с  маршрутами'
  id = gets.chomp.to_i
  case id
  when 1

    train_menu
  when 2
    station_menu
  when 3
    route_menu
  else
    exit
  end

end





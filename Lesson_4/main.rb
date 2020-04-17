# frozen_string_literal: true
#
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
def create_station(name)
  Station.new(name)
end

def create_train(number)
  number = CargoTrain.new(number)
  puts "Поезд #{number} Создан"

end

def create_route(name)
  names = []
  all_station_object = ObjectSpace.each_object(Station)
  all_station_object.each do |index|
    name.each do |second|
      if index.name == second
        names << index
        puts names
      end
    end


  end
  Route.new(names)


end

def add_route

end

def route_list

end

def route_menu
  loop do

    puts 'Введите желаемое действие'
    puts '1 Создать маршрут'
    puts '2 Список маршрутов'
    id = gets.chomp.to_i
    case id
    when 1
      puts 'Введите имена станций,минимум две станции через запятую'
      name = gets.chomp.split(',')


      create_route(name)

    when 2
      route_list

    else
      break end
  end
end

def station_menu
  loop do

    puts 'Введите желаемое действие'
    puts '1 Создать станцию'

    id = gets.chomp.to_i
    case id
    when 1
      puts 'Введите имя станции'
      name = gets.chomp.to_s
      create_station(name)

    else
      break
    end
  end
end

def train_menu
  loop do

  puts 'Введите желаемое действие'
  puts '1 Создать поезд'
  puts ' 2 Добавить маршрут'
  id = gets.chomp.to_i
  case id
  when 1
    puts 'Введите имя(номер) поезда'
    number = gets.chomp.to_i
    create_train(number)

  when 2
    add_route

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





# frozen_string_literal: true

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
    puts 'Select action'
    puts '1 Train actions'
    puts '2 Station actions'
    puts '3 Route actions'
    puts '4 All information'
  end

  private

  def train_name(train)
    puts "This train belongs to company #{train.view_comp_name}"
  end

  def wagons_info(train)
    if train.is_a?(PassengerTrain)
      train.wagons_list do |_index, wagon|
        puts "#{wagon.number},  #{wagon.free_places} seats #{wagon.busy} seats"
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
        puts "Train: #{train.number}, Type: #{train.train_type}"
        puts 'Wagons (number, free, occupied):'
        wagons_info(train)
      end
    end
  end

  def add_name(train)
    puts 'Enter Company Name'
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
        puts "id = #{index} - #{value.name} trains at station:
        #{value.trains}"
      end
    else
      puts 'No stations!'
    end
  end

  def remove_station(route)
    puts 'Select station'
    puts route.list

    stations_id = gets.chomp.to_i
    route.remove_station(@stations[stations_id])
  end

  def add_station(route)
    puts 'Select station'
    stations_list
    stations_id = gets.chomp.to_i
    route.add_station(@stations[stations_id], stations_id)
  end

  def create_route_input
    puts 'Enter station ids, minimum two stations separated by comma'
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
      puts "1 Add station to route #{route} "
      puts "2 Remove station from route #{route} "
      case gets.chomp.to_i
      when 1 then add_station(route)
      when 2 then remove_station(route)
      else
        break
      end
    end
  end

  def routes_menu_puts
    puts 'Enter desired action'
    puts '1 Create route'
    puts '2 Select route'
  end

  def pick_route
    if @routes.any?
      route_list
      route = gets.chomp.to_s
      route_menu(@routes[route])
    else
      'No routes'
    end
  end

  def routes_menu
    raise 'Need minimum 2 stations' unless @stations.count > 1

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
    puts 'Enter station name'
    name = gets.chomp.to_s
    @stations << Station.new(name)
    rescue RuntimeError => e
      puts e.message.to_s
      retry
  end
    puts "Station #{name} Created"
  end

  def station_menu
    loop do
      puts '1 Create station'
      puts '2 List stations'

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
    puts "Train #{train} selected, enter route number"
    route_list
    route_name = gets.chomp.to_s
    raise 'No such route' unless @routes[route_name]

    route_value = @routes[route_name]
    @trains[train.number].add_route(route_value)
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def create_cargo_train
    puts 'Enter cargo train name'
    train_number = gets.chomp.to_s
    @trains[train_number] = CargoTrain.new(train_number)
    puts "Train #{train_number} Created"
  end

  def create_passenger_train
    puts 'Enter passenger train name'
    train_number = gets.chomp.to_s
    @trains[train_number] = PassengerTrain.new(train_number)
    puts "Train #{train_number} Created"
  end

  def trains_list
    @trains.each do |name, value|
      puts "Train number = #{name} Type #{value.train_type}"
    end
  end

  def create_train
    puts 'Which train to create: 1 -- Cargo, 2 -- Passenger'
    case gets.chomp.to_i
    when 1 then create_cargo_train
    when 2 then create_passenger_train

    else
      raise 'There are only two types of trains'
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def remove_wagons(train)
    train.remove_wagon
  end

  def add_wagons_menu(train)
    puts "Your train is #{train.train_type} type"
    puts 'Which wagon to attach'
    puts '1 - Passenger '
    puts '2 - Cargo'
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
      else raise 'You only have a choice of two types'
      end

    train.add_wagon(wagon, number.to_s)
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def add_cargo_wagon(number)
    puts 'Enter volume in wagon'
    capacity = gets.chomp.to_i
    CargoWagon.new(capacity, number)
  end

  def add_passenger_wagon(number)
    puts 'Enter number of seats in wagon'
    places = gets.chomp.to_i
    PassengerWagon.new(places, number)
  end

  def train_menu_puts(train)
    puts "Train #{train.number} selected"
    puts '1 Add wagon'
    puts '2 Remove wagon'
    puts '8 Select wagon'
    puts '3 Add Route'
    puts '4 Forward on route'
    puts '5 Back on route'
    puts '6 Assign manufacturer company name'
    puts '7 Train manufacturer name'
  end

  def train_menu(train)
    raise 'Such train does not exist' unless @trains.value? train

    loop do
      train_menu_puts(train)
      case gets.chomp.to_i
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
    puts 'Select wagon'
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
    puts '1 Fill wagon'
    puts '2 Free volume'
    puts '3 Occupied volume'
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
    puts 'Enter volume'
    capacity = gets.chomp.to_i
    wagon.take_capacity(capacity)
  end

  def passenger_wagon_menu_puts
    puts '1 Take 1 seat in wagon'
    puts '2 Number of occupied seats'
    puts '3 Number of free seats'
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
    puts '1 Select train'
    puts '2 Create train'
  end

  def trains_menu
    loop do
      trains_menu_puts
      case gets.chomp.to_i
      when 1
        if @trains.any?

          puts 'Select train'
          trains_list
          train = gets.chomp.to_s
          train_menu(@trains[train])

        else
          puts 'No trains'

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

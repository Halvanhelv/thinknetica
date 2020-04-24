# frozen_string_literal: true

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

  def trains_list
    @trains.each do |train|
      yield train
    end
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
    raise 'Нет названия у станции' unless @name
    raise 'Название станции должно иметь минимум 6 символов' if @name.length < 6
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

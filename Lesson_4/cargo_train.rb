class CargoTrain < Train
  def initialize(number)
    super(number)
    @train_type = :cargo

  end



  def test
    station = Station.new('kazan')
    station1 = Station.new('piter')
    station2 = Station.new('rostov')
    route = Route.new([station, station1, station2])
    add_route(route)
    wagon = CargoWagon.new
    add_wagon(wagon)
    next_station
    next_station
    prev_station
  end
end
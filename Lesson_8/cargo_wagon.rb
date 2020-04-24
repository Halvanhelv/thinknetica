require_relative 'modules/company_name'
class CargoWagon < Wagon

  attr_reader :wagon_type, :capacity, :free_capacity
  def initialize(capacity, number)
    super(number)
    @wagon_type = :cargo
    @capacity = capacity
    @free_capacity = capacity
  end

  def take_capacity(capacity)
    raise 'Нет места.' if @free_capacity.zero?

    @free_capacity -= capacity
    puts "Теперь объёем равен: #{free_capacity}"
  end

  def busy_capacity
    @capacity - @free_capacity
  end

end

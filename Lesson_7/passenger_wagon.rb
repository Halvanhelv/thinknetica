# frozen_string_literal: true

require_relative 'modules/company_name'

class PassengerWagon < Wagon
  include CompanyName
  attr_reader :number, :places, :free_places
  def initialize(places, number)
    super(number)
    @places = places
    @wagon_type = :passenger
    @free_places = places

  end

  def take_place
    raise 'No free seats.' if @free_places.zero?

    @free_places -= 1
    puts "Now wagon has #{free_places} seats"
  end

  def busy
    @places - @free_places
  end
end

require_relative 'modules/company_name'

class PassengerWagon
  include CompanyName
  attr_reader :wagon_type
  def initialize
    @wagon_type = :passenger
  end
end

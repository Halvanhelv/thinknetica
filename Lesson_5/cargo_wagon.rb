require_relative 'modules/company_name'
class CargoWagon
  include CompanyName
  attr_reader :wagon_type
  def initialize
    @wagon_type = :cargo
  end
end

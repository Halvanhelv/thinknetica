module CompanyName
  def add_name(name)
    self.company_name = name
  end

  def view_comp_name
    company_name
  end

  protected

  attr_accessor :company_name
end
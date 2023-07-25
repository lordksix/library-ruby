require_relative 'person'

class Teacher < Person
  def initialize(specialization, age, name = 'unknown', parent_permmission: true)
    super(age, name, parent_permmission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

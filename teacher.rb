require_relative 'person'

class Teacher < Person
  attr_reader :specialization

  def initialize(specialization, age, name, parent_permission: true)
    super(age, 'Teacher', name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

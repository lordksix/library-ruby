require_relative 'person'

class Student < Person
  def initialize(classroom, age, name = 'unknown', parent_permmission: true)
    super(age, name, parent_permmission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end

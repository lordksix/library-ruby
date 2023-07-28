require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(classroom1, age, name, parent_permission: true)
    super(age, 'Student', name, parent_permission: parent_permission)
    @classroom = classroom1
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end

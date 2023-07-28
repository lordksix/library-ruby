require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id, :title

  # Constructor
  def initialize(age, title, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1...1000)
    @name = name
    @age = age
    @title = title
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_service?
    @parent_permission || of_age?
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals.push(rental)
    rental.person(self)
  end

  private

  def of_age?
    @age >= 18
  end
end

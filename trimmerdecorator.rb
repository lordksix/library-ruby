require_relative 'basedecorator'
require_relative 'person'
require_relative 'capitalizedecorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    return @nameable.correct_name[0, 10] if @nameable.correct_name.length > 10

    @nameable.correct_name
  end
end

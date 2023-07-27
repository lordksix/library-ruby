require_relative 'app'

def prompt
  puts 'Welcome to the School Library App!'
  loop do
    display_options
    option = take_input
    option_methods(option)

    break if option == 7
  end
end

def display_options
  puts 'Please choose one of the options: '
  puts '1. - List all books'
  puts '2. - List all people'
  puts '3. - Create a person'
  puts '4. - Create a book'
  puts '5. - Create a rental'
  puts '6. - List all rentals for a given person ID'
  puts '7. - Exit'
end

def take_input
  print 'Enter a number: '
  option = gets.chomp.to_i
  while option.nil? || option < 1 || option > 7
    puts 'Invalid input. Please, enter a number between 1 and 7!'
    print 'Enter a number: '
    option = gets.chomp.to_i
  end
  option
end

def option_methods(option)
  case option
  when 1
    display_all_books
  when 2
    display_all_people
  when 3
    create_person
  when 4
    create_book
  when 5
    create_rental
  when 6
    rental_list
  else
    puts 'Thank you for using this app!'
    exit
  end
end

def main
  app = App.new
  app.run
end

main

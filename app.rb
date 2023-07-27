require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def display_all_people
    @people.each_with_index do |people, index|
      puts "#{index + 1}) [#{people.title}] Name: #{people.name}, ID: #{people.id}, Age: #{people.age}"
    end
  end

  def display_all_books
    @books.each_with_index do |book, index|
      puts "#{index + 1}) Title: '#{book.title}', Author: '#{book.author}'"
    end
  end

  def create_person
    print 'Do you want to create a Student(1) or a Teacher(2)? [Input the number]: '
    p_option = gets.chomp.to_i
    while p_option != 1 && p_option != 2
      puts 'Invalid input. Please enter 1 or 2:'
      p_option = gets.chomp.to_i
    end
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    if p_option == 1
      print 'Has parent permission [Y/N]: '
      permission = 'a'
      while permission != 'Y' && permission != 'N'
        puts 'Invalid input. Please enter Y or N:'
        permission = gets.chomp.upcase
      end
      permission == 'Y' ? parent_permission = true : parent_permission = false
      create_student(name, age, parent_permission, classroom: 'class')
    else
      print 'Specialization: '
      specialization = gets.chomp
      create_teacher(name, age, specialization)
    end
    puts 'Person created successfully'
  end

  def create_teacher(name, age, specialization)
    teacher = Teacher.new(specialization, age, name)
    @people << teacher
  end

  def create_student(name, age, parent_permission, classroom)
    classroom_instance = Classroom.new(classroom)
    student = Student.new(classroom_instance, age, name)
    @people << student
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rental
    if @books.length() >= 1 && @people.length() >= 1
      puts 'Select a book from the following list by number'
      display_all_books
      print 'Book number: '
      book_index = gets.chomp.to_i
      while book_index.nil? ||book_index < 1 || book_index > (@books.length() + 1)
        puts "Invalid input. Please enter a number between 1 and #{@books.length}, including both:"
        p_option = gets.chomp.to_i
      end
      puts 'Select a person from the following list by number (not id)'
      display_all_people
      print 'Person number: '
      person_index = gets.chomp.to_i
      while person_index.nil? || person_index < 1 || person_index > (@people.length() + 1)
        puts "Invalid input. Please enter a number between 1 and #{@people.length()}, including both:"
        p_option = gets.chomp.to_i
      end
      print 'Date: '
      date = gets.chomp

      rental = Rental.new(date, @books[book_index], @people[person_index])
      @rentals << rental

      puts 'Rental created successfully'
    elsif @books.length() < 1
      puts 'No books to rent, please create a book'
    else
      puts 'No people available, please create a person'
    end
  end

  def rental_list
    puts 'Enter ID of the person'
    display_all_people
    person_id = gets.chomp.to_i
    while person_id.nil? || person_id < 1 || person_id > (@people.length + 1)
      puts "Invalid input. Please enter a number between 1 and #{@people.length}, including both:"
      p_option = gets.chomp.to_i
    end
    person = @people.select { |p| p.id == person_id }[0]
    puts 'Rentals: '
    if person.rentals.length() > 0
      person.rentals.each_with_index do |rental, index|
        puts "#{index + 1}) Book: #{rental.book.title}, Date: #{rental.date}"
      end
    else
      puts 'Person does not have any book rented'
    end
  end

  def run
    prompt
  end
end

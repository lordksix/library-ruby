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
    if @people.empty?
      puts 'No people registered'
    else
      @people.each_with_index do |people, index|
        puts "#{index + 1}) [#{people.title}] Name: #{people.name}, ID: #{people.id}, Age: #{people.age}"
      end
    end
  end

  def display_all_books
    if @books.empty?
      puts 'No books registered'
    else
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Title: '#{book.title}', Author: '#{book.author}'"
      end
    end
  end

  def create_person
    personal_data = create_personal_data_person
    if personal_data[2] == 1
      print 'Has parent permission [Y/N]: '
      permission = gets.chomp.upcase
      while permission != 'Y' && permission != 'N'
        puts 'Invalid input. Please enter Y or N:'
        permission = gets.chomp.upcase
      end
      if permission == 'Y'
        create_student(personal_data[0], personal_data[1], true, 'class')
      else
        create_student(personal_data[0], personal_data[1], false, 'class')
      end
    else
      print 'Specialization: '
      specialization = gets.chomp
      create_teacher(personal_data[0], personal_data[1], specialization)
    end
    puts 'Person created successfully'
  end

  def create_teacher(name, age, specialization)
    teacher = Teacher.new(specialization, age, name)
    @people << teacher
  end

  def create_student(name, age, parent_permission, classroom_)
    classroom = Classroom.new(classroom_)
    student = Student.new(classroom, age, name, parent_permission: parent_permission)
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
    if @books.length >= 1 && @people.length >= 1
      puts 'Select a book from the following list by number'
      display_all_books
      print 'Book number: '
      book_index = gets.chomp.to_i
      book_index = get_index(book_index, @books)
      puts 'Select a person from the following list by number (not id)'
      display_all_people
      print 'Person number: '
      person_index = gets.chomp.to_i
      person_index = get_index(person_index, @people)
      check_authorization(book_index, person_index)
    else
      puts 'No books or people available'
    end
  end

  def rental_list
    puts 'Enter ID of the person'
    display_all_people
    person_id = gets.chomp.to_i
    person = @people.select { |p| p.id == person_id }
    check_rental(person)
  end

  def run
    prompt
  end

  private

  def get_index(input, array)
    while input.nil? || input < 1 || input > (array.length + 1)
      puts "Invalid input. Please enter a number between 1 and #{array.length}, including both:"
      gets.chomp.to_i
    end
    input
  end

  def check_authorization(book_index, person_index)
    book_index -= 1
    person_index -= 1
    if @people[person_index].can_use_service?
      print 'Date: '
      date = gets.chomp
      rental = Rental.new(date, @books[book_index], @people[person_index])
      @rentals << rental
      puts 'Rental created successfully'
    else
      puts 'Not authorize person'
    end
  end

  def check_rental(person)
    if person.empty?
      puts 'No person with that ID'
    else
      person = person[0]
      puts 'Rentals: '
      if person.rentals.length.positive?
        person.rentals.each_with_index do |rental, index|
          puts "#{index + 1}) Book: #{rental.book.title}, Date: #{rental.date}"
        end
      else
        puts 'Person does not have any book rented'
      end
    end
  end

  def create_personal_data_person
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
    [name, age, p_option]
  end
end

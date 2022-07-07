require 'date'
@months = (1..12).map {|m| Date::MONTHNAMES[m].downcase.to_sym}

# @students = []

students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :october},
  {name: "The Wicked Witch of the West", cohort: :september},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :january},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]

def print_header
  if @students.empty?
    puts "We have no students"
  else
    puts "The students of Villains Academy"
    puts "-------------"
  end
end

def print_students_list(by_cohort = false)
  if !by_cohort
    @students.each_with_index { |student, idx|
      puts "#{idx}. #{student[:name]} (#{student[:cohort]} cohort)"
    }
  else
    cohort_array = @students.map { |student| student[:cohort]}.uniq.sort_by &@months.method(:index)
    count = 0
    cohort_array.each { |cohort|
      @students.select { |student| student[:cohort] == cohort }.each { |student| 
        puts "#{count}. #{student[:name]} (#{student[:cohort]} cohort)"
        count += 1
      }
    }
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{"s" if @students.count != 1}" if !@students.empty?
end

def input_students
  months_hash = @months.each_with_object({}) { |month, hash| hash[@months.index(month) + 1] = month}
  puts "Please enter the names of the students"
  puts "To finish, just hit return"
  name = gets.chomp
  while !name.empty?
    cohort = ""
    while true
      puts "Enter a cohort or hit return for the current month"
      cohort = gets.chomp
      cohort = (cohort.empty?) ? months_hash[Date.today.strftime("%m").to_i] : cohort.downcase.to_sym
      break if months_hash.values.include? cohort
      puts "You did not enter a valid cohort"
    end
    @students << {name: name, cohort: cohort}
    puts "Now we have #{@students.count} student#{"s" if @students.count != 1}"
    name = gets.chomp
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1" then input_students
    when "2" then show_students
    when "9" then Exit
    else puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  @students = []
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
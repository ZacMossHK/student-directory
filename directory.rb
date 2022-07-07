require 'date'
MONTHS = (1..12).map {|m| Date::MONTHNAMES[m].downcase.to_sym}

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

def print_header(names)
  if names.empty?
    puts "We have no students"
  else
    puts "The students of Villains Academy"
    puts "-------------"
  end
end

def print(names, by_cohort = false)
  if !by_cohort
    names.each_with_index { |student, idx|
      puts "#{idx}. #{student[:name]} (#{student[:cohort]} cohort)"
    }
  else
    cohort_array = names.map { |student| student[:cohort]}.uniq.sort_by &MONTHS.method(:index)
    count = 0
    cohort_array.each { |cohort|
      names.select { |student| student[:cohort] == cohort }.each { |student| 
        puts "#{count}. #{student[:name]} (#{student[:cohort]} cohort)"
        count += 1
      }
    }
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great student#{"s" if names.count != 1}" if !names.empty?
end

def input_students
  months_hash = MONTHS.each_with_object({}) { |month, hash| hash[MONTHS.index(month) + 1] = month}
  puts "Please enter the names of the students"
  puts "To finish, just hit return"
  students = []
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
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} student#{"s" if students.count != 1}"
    name = gets.chomp
  end
  students
end

def interactive_menu
  students = []
  loop do
    #1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    selection = gets.chomp
    case selection
      when "1" then students = input_students
      when "2"
        print_header(students)
        print(students, true)
        print_footer(students)
      when "9" then Exit
      else puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
# students = input_students
# print_header(students)
# print(students, true)
# print_footer(students)
@students = []
def input_students
  continue = "y"
  while continue == "y"
    puts "\n---Please enter the name of the student:"
    name = confirm_input
    name = "n/a" if name == ""
    puts "\n---Please enter the cohort date of the student:"
    cohort = cohort_input       
    puts "\n---Please enter a hobby of the student:"
    hobby = confirm_input
    hobby = "n/a" if hobby == "" 
    puts "\n---Please enter the date of birth of the student:"
    date_of_birth = confirm_input
    date_of_birth = "n/a" if date_of_birth == ""
    puts "\n---Please enter the height(cm) of the student:"
    height = confirm_input
    height = "n/a" if height == ""
    push_student(name, cohort, hobby, date_of_birth, height) 
    student_count
    puts "\n---Add another student? enter y/n:"
    continue = STDIN.gets.strip
  end
  
  @students
end

def student_count
plural = ""
  plural = "s" if @students.length > 1 
  puts "\n---Now we have #{@students.count} student#{plural}"
end

def confirm_input
  input = STDIN.gets.chomp
  puts "\n---You entered #{input}, is this correct? y/n ?"
  choice = "n"
  choice  = STDIN.gets.chomp
    until choice == "y"
      puts "---\nPlease re-enter:"
      input = STDIN.gets.strip
      puts "---\nYou entered #{input}, is this correct? y/n?"  
      choice  = STDIN.gets.chomp
    end
  input
end  

def cohort_input
  choice = STDIN.gets.strip
  months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
   until months.include?(choice.downcase.to_sym)
    puts "\n---Please enter a valid month:"
    choice = STDIN.gets.strip
    end  
  puts "\n---Student, added to #{choice.capitalize}"
  choice.capitalize.to_sym
  end

def push_student(name, cohort, hobby, date_of_birth, height)
  @students << {name: name, cohort: cohort , hobby: hobby, date_of_birth: date_of_birth, height: height}
end    

def print_header
  puts "THE STUDENTS".center(100)
  puts "---------------------\n".center(100)
end

def print(students)
  if @students.length == 0
    puts "\nThere are no students in the directory!\n".center(100)
  return
  end
  i = 0
  @students = @students.sort_by {|student| student[:cohort]}
  until i >= @students.length
    puts "-NAME: #{@students[i][:name]}\n".center(100)
    puts "-COHORT MONTH: #{@students[i][:cohort]}\n".center(100)
    puts "-HOBBY: #{@students[i][:hobby]}\n".center(100)
    puts "-BORN: #{@students[i][:date_of_birth]}\n".center(100)
    puts "-HEIGHT: #{@students[i][:height]}\n".center(100)
    puts "-------".center(100)
    i += 1
  end  
end

def print_footer(students)
  return if @students.length == 0
  plural = ""
  plural = "s" if @students.length > 1
  puts "Overall, we have #{@students.count} great student#{plural}".center(100)
  #find is number of students is great than 1
  # interpolate an "S" if its going to be plural"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  # open the file for writing
  file = File.open("file.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby], student[:date_of_birth], student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "file.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort, hobby, date_of_birth, height = line.chomp.split(',')
    #@students << {name: name, cohort: cohort.to_sym, hobby: hobby, date_of_birth: date_of_birth, height: height}
    push_student(name, cohort, hobby, date_of_birth, height)
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end


def process(selection)
  case selection
    when "1" then input_students
    when "2" then show_students
    when "3" then save_students
    when "4" then load_students   
    when "9" then exit
    else puts "\nI don't know what you mean, try again"
  end
end

def print_menu
  
  puts "\n1. Input the students"
  puts "2. Show the students"
  puts "3. Save students to file"
  puts "4. Load students from file"
  puts "9. Exit\n" 
  puts 
end

def show_students
  print_header
  print(@students)
  print_footer(@students)
end

try_load_students
interactive_menu

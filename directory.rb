@students = []
def input_students
  continue = "y"
  while continue == "y"
    puts "\n---Please enter the name of the student:".center(60)
    name = confirm_input
    name = "n/a" if name == ""
    puts "\n---Please enter the cohort date of the student:".center(60)
    cohort = cohort_input       
    puts "\n---Please enter a hobby of the student:".center(60)
    hobby = confirm_input
    hobby = "n/a" if hobby == "" 
    puts "\n---Please enter the date of birth of the student:".center(60)
    date_of_birth = confirm_input
    date_of_birth = "n/a" if date_of_birth == ""
    puts "\n---Please enter the height(cm) of the student:".center(60)
    height = confirm_input
    height = "n/a" if height == ""
    push_student(name, cohort, hobby, date_of_birth, height) 
    student_count
    puts "\n---Add another student? enter y/n:".center(60)
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
  puts "\n---You entered #{input}, is this correct? y/n ?".center(60)
  choice = "n"
  choice  = STDIN.gets.chomp
    until choice == "y"
      puts "---\nPlease re-enter:".center(60)
      input = STDIN.gets.strip
      puts "---\nYou entered #{input}, is this correct? y/n?".center(60)
      choice  = STDIN.gets.chomp
    end
  input
end  

def cohort_input
  choice = STDIN.gets.strip
  months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
   until months.include?(choice.downcase.to_sym)
    puts "\n---Please enter a valid month:".center(60)
    choice = STDIN.gets.strip
    end  
  puts "\n---Student, added to #{choice.capitalize}".center(60)
  choice.capitalize.to_sym
  end

def push_student(name, cohort, hobby, date_of_birth, height)
  @students << {name: name, cohort: cohort , hobby: hobby, date_of_birth: date_of_birth, height: height}
end    

def print_header
  puts "THE STUDENTS".center(100)
  puts "<><><><><><><><>\n".center(100)
end

def print(students)
  if @students.length == 0
    puts "\nThere are no students in the directory!\n".center(100)
  return
  end
  i = 0
  @students = @students.sort_by {|student| student[:cohort]}
  until i >= @students.length
    puts "-NAME: #{@students[i][:name]}".center(100)
    puts "-COHORT: #{@students[i][:cohort]}".center(100)
    puts "-HOBBY: #{@students[i][:hobby]}".center(100)
    puts "-BORN: #{@students[i][:date_of_birth]}".center(100)
    puts "-HEIGHT: #{@students[i][:height]}\n".center(100)
    puts "{{{{{{{{{}}}}}}}}}\n".center(100)
    i += 1
  end  
end

def search_initial
  i = 0
    puts "Please enter the first initial of the student..."
    initial = gets.strip
    search_names = @students.reject {|each| each[:name].chr != initial}
    if search_names.length == 0
      puts "searching......"
      sleep(2)
      puts "No students found who's first initial is....#{initial}"
      return
    else
      puts "searching......"
      sleep(2)
      puts "Search results for initial '#{initial}'".center(100)
      until i >= search_names.length
        puts "-NAME: #{search_names[i][:name]}".center(100)
        puts "-COHORT: #{search_names[i][:cohort]}".center(100)
        puts "-HOBBY: #{search_names[i][:hobby]}".center(100)
        puts "-BORN: #{search_names[i][:date_of_birth]}".center(100)
        puts "-HEIGHT: #{search_names[i][:height]}\n".center(100)
        puts "{{{{{{{{{}}}}}}}}}\n".center(100)
        i += 1
    end 
  end
end

def print_footer(students)
  return if @students.length == 0
  plural = ""
  plural = "s" if @students.length > 1
  puts "Overall, we have #{@students.count} great student#{plural}".center(100)
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  puts "Please enter the filename (.csv):"
  filename = gets.chomp
  file = File.open(filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby], student[:date_of_birth], student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "\nSaving......."
      sleep(4)
  puts  "\nSaved successfully to #{filename}"
  puts
end

def load_students(filename = "file.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort, hobby, date_of_birth, height = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby, date_of_birth: date_of_birth, height: height}
  end
  file.close
end

def try_load_students
  ARGV.first.nil? ? filename = "file.csv" : filename = ARGV.first
  if File.exists?(filename) 
    load_students(filename)
     puts "\nLoaded #{@students.count} students details from: #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

def process(selection)
  case selection
    when "1" 
      puts "\nYou have chosen to add a student"
      sleep(2)
      input_students
    when "2" 
      puts "\nView students"
      sleep(2)
      puts "\nLoading student list.........."
      sleep(4)
      show_students
    when "3"
      save_students
    when "4"
      puts "Please enter the name of the file (eg data.csv)" 
      puts  "or leave empty to open the default file, students.csv"
      load_filename = gets.chomp
      load_filename.empty? ? load_students : load_students(load_filename)
      puts "\nLoading......."
      sleep(3)
      puts "Complete\n"
      load_students
    when "5" then search_initial  
    when "9" then exit
    else puts "\nI don't know what you mean, try again"
  end
end

def print_menu
  puts "\nPlease select an option......"
  puts
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save students to file"
  puts "4. Load students from file"
  puts "5. Search by Initial"
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

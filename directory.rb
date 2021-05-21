def input_students
  $students = []
  continue = "y"
  while continue == "y"
    puts "---Please enter the name of the student"
    name = confirm_input
      if name == ""
        name = "n/a"
      end 
    puts "\n---Please enter the cohort date of the student"
    cohort = cohort_input       
    puts "\n---Please enter a hobby of the student"
    hobby = confirm_input
      if hobby == "" 
        hobby = "n/a"
      end  
    puts "\n---Please enter the date of birth of the student"
    date_of_birth = confirm_input
      if date_of_birth == "" 
        date_of_birth = "n/a"
      end  
    puts "\n---Please enter the height(cm) of the student"
    height = confirm_input
      if height == ""
        height = "n/a"
      end  
    save_student(name, cohort, hobby, date_of_birth, height)  
    puts "\n---Add another student? enter y/n"
    continue = gets.strip
  end
  $students
end

def confirm_input
  input = gets.chomp
  puts "\n---you entered #{input}, is this correct? y/n?"
  choice = "n"
  choice  = gets.chomp
    until choice == "y"
      puts "---\nplease re-enter:"
      input = gets.strip
      puts "---\nyou entered #{input}, is this correct? y/n?"  
      choice  = gets.chomp
    end
  input
end  

def cohort_input
  choice = gets.strip
  months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
   until months.include?(choice.to_sym)
    puts "\n---Please enter a valid month:"
    choice = gets.strip
    end  
  puts "\n---student, added to #{choice}"
  choice.to_sym
  end

def save_student(name, cohort, hobby, date_of_birth, height)
  $students << {name: name, cohort: cohort , hobby: hobby, date_of_birth: date_of_birth, height: height}
  plural = ""
  plural = "s" if $students.length > 1 
  puts "\n---Now we have #{$students.count} student#{plural}"
end    

def print_header
  puts "THE STUDENTS".center(100)
  puts "---------------------".center(100)
end

def print(students)
  i = 0
  students = students.sort_by {|student| student[:cohort]}
  until i >= students.length
    puts "-NAME: #{students[i][:name]}".center(100)
    puts "\n"
    puts "-COHORT MONTH: #{students[i][:cohort]}".center(100)
    puts "\n"
    puts "-HOBBY: #{students[i][:hobby]}".center(100)
    puts "\n"
    puts "-BORN: #{students[i][:date_of_birth]}".center(100)
    puts "\n"
    puts "-HEIGHT: #{students[i][:height]}".center(100)
    puts "\n"
    puts "-------".center(100)
    i += 1
  end  
end

def print_footer(students)
  plural = ""
  plural = "s" if students.length > 1 
  puts "\n"
  puts "Overall, we have #{students.count} great student#{plural}".center(100)
  #find is number of students is great than 1
  # interpolate an "S" if its going to be plural"
end

students = input_students
print_header
print(students)
print_footer(students)

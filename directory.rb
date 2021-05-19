def input_students
  $students = []
  continue = "yes"
  while continue == "yes"
    puts "Please enter the name of the student".center(100)
    name = gets.chomp
    puts "Please enter a hobby of the student".center(100)
    hobby = gets.chomp
    puts "Please enter the date of birth of the student".center(100)
    date_of_birth = gets.chomp
    puts "Please enter the height(cm) of the student".center(100)
    height = gets.chomp
    save_student(name, hobby, date_of_birth, height)  
    puts "Add another student? enter yes or no".center(100)
    continue = gets.chomp 
  end
  $students
end

def save_student(name, hobby, date_of_birth, height)
  $students << {name: name, cohort: :november, hobby: hobby, date_of_birth: date_of_birth, height: height}
  puts "Now we have #{$students.count} students".center(100)
end    

def print_header
  puts "The students of villains Academy".center(100)
  puts "---------------------".center(100)
end

def print(students)
  i = 0
  until i >= students.length
    puts "-NAME: #{students[i][:name]}".center(100)
    puts "-COHORT MONTH: #{students[i][:cohort]}".center(100)
    puts "-HOBBY: #{students[i][:hobby]}".center(100)
    puts "-BORN: #{students[i][:date_of_birth]}".center(100)
    puts "-HEIGHT: #{students[i][:height]}".center(100)
    puts "-------".center(100)
    i += 1
  end  
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(100)
end

students = input_students
print_header
print(students)
print_footer(students)

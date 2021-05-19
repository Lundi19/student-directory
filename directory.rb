def input_students
  $students = []
  continue = "yes"
  while continue == "yes"
    puts "Please enter the name of the student"
    name = gets.chomp
    puts "Please enter a hobby of the student"
    hobby = gets.chomp
    puts "Please enter the date of birth of the student"
    date_of_birth = gets.chomp
    puts "Please enter the height(cm) of the student"
    height = gets.chomp
    save_student(name, hobby, date_of_birth, height)  
    puts "Add another student? enter yes or no"
    continue = gets.chomp 
  end
  $students
end

def save_student(name, hobby, date_of_birth, height)
  $students << {name: name, cohort: :november, hobby: hobby, date_of_birth: date_of_birth, height: height}
  puts "Now we have #{$students.count} students"
end    

def print_header
  puts "The students of villains Academy"
  puts "---------------------"
end

def print(students)
  i = 0
  until i >= students.length
    puts "#{students[i][:name]} - (#{students[i][:cohort]} 
    cohort) - HOBBY: #{students[i][:hobby]} - BORN: 
    #{students[i][:date_of_birth]} - HEIGHT: #{students[i][:height]}"
    i += 1
  end  
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)

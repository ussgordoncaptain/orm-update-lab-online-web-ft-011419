require_relative "../config/environment.rb"

class Student

  # Remember, you can accesst
def initialize(name, grade, id=nil)
  @name = name 
  @grade = grade 
  @id = id 
end 
attr_accessor :name, :grade
attr_reader :id 

def self.create_table 
  sql_statement = <<-SQL
    CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)
  SQL
  DB[:conn].execute(sql_statement)
end 
  def self.drop_table
    sql_statement = "DROP TABLE students"
    DB[:conn].execute(sql_statement)
  end
  def save 
    if self.id 
       self.update
    else
      sql = "INSERT INTO students(name, grade) VALUES(?, ?)"
      DB[:conn].execute(sql, self.name, self.grade)
      sql_2 = "SELECT last_insert_rowid() FROM students"
      @id =  DB[:conn].execute(sql_2)[0][0]
    end
  end
  def self.create(name, grade)
   student_new = self.new(name, grade)
    Student.save
    return student_new
  end
  def self.new_from_db(student_arr)
    id = student_arr(0)
    name = student_arr(1)
    grade = student_arr(2)
    stu = self.new(name, grade, id)
    return stu
  end
  def self.find_by_name(name)
    sql_query= "SELECT * FROM students WHERE name=? ;"
    arr_of_query= DB[:conn].execute(sql_query, name)
    self.new_from_db(arr_of_query)
    
  end
  def update(student) 
    
  end
end

class CreateCoursesStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_students do |t|
      t.integer :schedule_id
      t.integer :student_id
    end
  end
end

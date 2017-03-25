class FixColumnNameCoursesStudents < ActiveRecord::Migration[5.0]
  def change
  	rename_column :courses_students, :schedule_id, :course_id
  end
end

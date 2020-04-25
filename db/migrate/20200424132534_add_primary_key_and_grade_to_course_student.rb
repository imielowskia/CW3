class AddPrimaryKeyAndGradeToCourseStudent < ActiveRecord::Migration[6.0]
  def change
    rename_table 'courses_students', 'course_students'
    add_column :course_students, :id, :primary_key
    add_column :course_students, :grade, :integer, default: 0
  end
end

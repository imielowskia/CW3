class Student < ApplicationRecord
  has_and_belongs_to_many :groups
  has_many :course_students
  has_many :courses, through: :course_students

  def fname
    "#{name} #{sname}"
  end
end

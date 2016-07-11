class CourseInstructor < ActiveRecord::Base
  has_many :course_id, inverse_of: :course_code
end

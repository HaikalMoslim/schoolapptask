class Enrollment < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  belongs_to :student

  validates :student_id, presence: true
  validates :teacher_id, presence: true
end 
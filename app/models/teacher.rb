class Teacher < ApplicationRecord
    has_many :enrollments
    has_many :students, through: :enrollments

    validates :name, presence: true
  end
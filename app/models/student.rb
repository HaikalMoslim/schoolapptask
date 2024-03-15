class Student < ApplicationRecord
    has_many :enrollments
    has_many :teachers, through: :enrollments

    validates :name, presence: true
  end
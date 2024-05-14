class Teacher < ApplicationRecord
    has_many :enrollments
    has_many :students, through: :enrollments
    belongs_to :user
    validates :name, presence: true
    belongs_to :school
end
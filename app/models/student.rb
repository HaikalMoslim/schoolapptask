class Student < ApplicationRecord
    has_many :enrollments
    has_many :teachers, through: :enrollments
    belongs_to :user
    validates :name, presence: true
    has_many :receipts
  end
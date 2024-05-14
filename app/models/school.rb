class School < ApplicationRecord
    geocoded_by :address
    after_validation :geocode, if: :address_changed?
    has_many :students
    has_many :teachers
end

class AddSchoolIdToTeacherAndStudent < ActiveRecord::Migration[7.1]
  def change
    add_reference :students, :school, foreign_key: true
    add_reference :teachers, :school, foreign_key: true
  end
end

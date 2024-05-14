class AddClassNameToEnrollment < ActiveRecord::Migration[7.1]
  def change
    add_column :enrollments, :class_name, :string
  end
end

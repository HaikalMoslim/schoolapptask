class AddAboutToTeacher < ActiveRecord::Migration[7.1]
  def change
    add_column :teachers, :about, :string
  end
end

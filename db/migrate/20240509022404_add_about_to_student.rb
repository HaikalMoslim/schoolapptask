class AddAboutToStudent < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :about, :string
  end
end

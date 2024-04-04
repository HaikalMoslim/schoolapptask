class RemoveCityAndStateFromSchool < ActiveRecord::Migration[7.1]
  def change
    remove_column :schools, :city, :string
    remove_column :schools, :state, :string
  end
end

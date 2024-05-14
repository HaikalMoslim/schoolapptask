class AddAboutAndWebsiteToSchool < ActiveRecord::Migration[7.1]
  def change
    add_column :schools, :about, :string
    add_column :schools, :weblink, :string, default: nil
  end
end

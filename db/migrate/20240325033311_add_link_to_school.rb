class AddLinkToSchool < ActiveRecord::Migration[7.1]
  def change
    add_column :schools, :link, :string
  end
end

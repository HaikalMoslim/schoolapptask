class CreateFees < ActiveRecord::Migration[7.1]
  def change
    create_table :fees do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.float :total
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateReceipts < ActiveRecord::Migration[7.1]
  def change
    create_table :receipts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.float :total
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

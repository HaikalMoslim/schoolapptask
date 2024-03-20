class AddUserToReceipt < ActiveRecord::Migration[7.1]
  def change
    add_reference :receipts, :user, null: false, foreign_key: true
  end
end

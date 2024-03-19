class AddUserIdToReceipts < ActiveRecord::Migration[7.1]
  def change
    add_reference :receipts, :user, foreign_key: true
  end
end

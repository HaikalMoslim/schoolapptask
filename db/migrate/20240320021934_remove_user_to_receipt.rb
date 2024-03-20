class RemoveUserToReceipt < ActiveRecord::Migration[7.1]
  def change
    remove_column :receipts, :user_id, :integer
  end
end

class RemoveUserIdFromPayment < ActiveRecord::Migration[7.1]
  def change
    remove_column :payments, :user_id, :integer
    remove_column :payments, :receipt_id, :integer
  end
end

class RemoveReceiptFromPayment < ActiveRecord::Migration[7.1]
  def change
    remove_column :payments, :receipt_id, :integer
  end
end

class RemoveReceiptNumberFromReceipts < ActiveRecord::Migration[7.1]
  def change
    remove_column :receipts, :receipt_number, :string
  end
end

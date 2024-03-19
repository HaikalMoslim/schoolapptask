class AddPhoneToReceipts < ActiveRecord::Migration[7.1]
  def change
    add_column :receipts, :phone, :string
  end
end

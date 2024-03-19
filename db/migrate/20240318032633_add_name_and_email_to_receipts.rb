class AddNameAndEmailToReceipts < ActiveRecord::Migration[7.1]
  def change
    add_column :receipts, :name, :string
    add_column :receipts, :email, :string
  end
end

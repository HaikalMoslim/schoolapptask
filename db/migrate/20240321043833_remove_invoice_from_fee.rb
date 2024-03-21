class RemoveInvoiceFromFee < ActiveRecord::Migration[7.1]
  def change
    remove_column :fees, :invoice_id, :integer
  end
end

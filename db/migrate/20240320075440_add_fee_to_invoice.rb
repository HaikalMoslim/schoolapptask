class AddFeeToInvoice < ActiveRecord::Migration[7.1]
  def change
    add_reference :invoices, :fee, null: false, foreign_key: true
  end
end

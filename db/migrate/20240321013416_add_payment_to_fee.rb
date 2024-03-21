class AddPaymentToFee < ActiveRecord::Migration[7.1]
  def change
    add_column :fees, :payment_succeeded, :boolean, default: false
  end
end

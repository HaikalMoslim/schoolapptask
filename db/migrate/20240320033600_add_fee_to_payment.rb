class AddFeeToPayment < ActiveRecord::Migration[7.1]
  def change
    add_reference :payments, :fee, null: false, foreign_key: true
  end
end

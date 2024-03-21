class AddUserToPayment < ActiveRecord::Migration[7.1]
  def change
    add_reference :payments, :user, foreign_key: true
  end
end

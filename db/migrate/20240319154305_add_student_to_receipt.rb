class AddStudentToReceipt < ActiveRecord::Migration[7.1]
  def change
    add_reference :receipts, :student, null: false, foreign_key: true
    end
end

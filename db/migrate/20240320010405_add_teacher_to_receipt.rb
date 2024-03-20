class AddTeacherToReceipt < ActiveRecord::Migration[7.1]
  def change
    add_reference :receipts, :teacher, null: false, foreign_key: true
  end
end

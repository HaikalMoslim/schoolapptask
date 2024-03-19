class AddTeacherIdToReceipts < ActiveRecord::Migration[7.1]
  def change
    add_reference :receipts, :teacher, foreign_key: true
  end
end

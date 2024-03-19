class RemoveStudentIdToReceipts < ActiveRecord::Migration[7.1]
  def change
    remove_column :receipts, :student_id, :integer
  end
end

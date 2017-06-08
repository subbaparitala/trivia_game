class AddTotalMarksToTests < ActiveRecord::Migration[5.0]
  def change
  	add_column :tests, :total_marks, :decimal
  end
end

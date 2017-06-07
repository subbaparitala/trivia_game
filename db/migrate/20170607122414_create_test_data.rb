class CreateTestData < ActiveRecord::Migration[5.0]
  def change
    create_table :test_data do |t|
      t.integer :question_id
      t.integer :answer_id
      t.integer :test_id

      t.timestamps
    end
  end
end

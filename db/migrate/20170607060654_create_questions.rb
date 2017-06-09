class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :description
      t.integer :user_id
      t.integer :correct_answer
      t.timestamps
    end
  end
end

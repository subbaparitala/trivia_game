class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :option1 
      t.string :option2
      t.string :option3
      t.string :option4
      t.timestamps
    end
  end
end

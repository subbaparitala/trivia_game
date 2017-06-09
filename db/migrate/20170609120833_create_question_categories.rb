class CreateQuestionCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :question_categories do |t|
      t.integer :question_id
      t.integer :category_id

      t.timestamps
    end
  end
end

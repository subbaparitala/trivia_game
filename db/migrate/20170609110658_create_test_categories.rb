class CreateTestCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :test_categories do |t|
      t.integer :test_id
      t.integer :category_id

      t.timestamps
    end
  end
end

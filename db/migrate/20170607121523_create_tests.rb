class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.integer :user_id
      t.string :category_ids
      t.timestamps
    end
  end
end

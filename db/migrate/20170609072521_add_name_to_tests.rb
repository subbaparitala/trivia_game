class AddNameToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :name, :string
    add_column :tests, :status, :string
    add_column :tests, :last_page, :integer
  end
end

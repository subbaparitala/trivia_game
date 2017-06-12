class AddTestTokenIntoTests < ActiveRecord::Migration[5.0]
  def change
  	add_column :tests, :test_token, :string
  end
end

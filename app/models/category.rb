class Category < ApplicationRecord
	has_many :test_categories
	has_many :tests, through: :test_categories
	has_many :question_categories
	has_many :questions, through: :question_categories
end

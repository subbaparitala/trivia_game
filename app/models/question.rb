class Question < ApplicationRecord
	has_one :answer
	serialize :category_ids, Array
	belongs_to :user
	accepts_nested_attributes_for :answer
end

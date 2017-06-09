class Question < ApplicationRecord
	has_one :answer
	serialize :category_ids, Array
	belongs_to :user
	accepts_nested_attributes_for :answer
  has_reputation :votes, source: :user, aggregated_by: :sum
end

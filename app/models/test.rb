class Test < ApplicationRecord
	belongs_to :user
	serialize :category_ids, Array
	has_many :test_datums
end

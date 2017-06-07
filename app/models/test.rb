class Test < ApplicationRecord
	belongs_to :user
	serialize :category_ids, Array
end

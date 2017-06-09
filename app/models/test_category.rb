class TestCategory < ApplicationRecord
	belongs_to :test
	belongs_to :category
end

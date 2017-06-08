class Test < ApplicationRecord
	belongs_to :user
	serialize :category_ids, Array
	has_many :test_datums

	def count_total_marks
		count = 0
		self.test_datums.each do |test_data|
			if Question.find(test_data.question_id).correct_answer.to_i.eql?(test_data.answer_id.to_i) 
		    count = count + 4;
		    else
		    count = count - 1;
		    end
       end
      self.update_attributes(total_marks: count)
	end
end

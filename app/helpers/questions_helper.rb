module QuestionsHelper
	def correct_answer question
		case question.correct_answer
		when 1
			question.answer.option1
		when 2
			question.answer.option2
		when 3
			question.answer.option3
		when 4
			question.answer.option4
		end
	end
end

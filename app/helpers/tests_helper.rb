module TestsHelper
  def prev_answer i
  	@test_data.answer_id.to_i.eql?(i) rescue false
  end

  def test_answer answer_id
   case answer_id.to_i
   when 1
   	return "(A)"
   when 2
    return "(B)"
   when 3
    return "(C)"
   when 4
    return "(D)"
   end	
  end
  
  def check_answer answer_id,question_id
   html = Question.find(question_id).correct_answer.to_i.eql?(answer_id.to_i) ? "<span class='col_green'>Correct Answer<span>" : "<span class='col_red'>Wrong Answer</span>"
   return html.html_safe
  end
end

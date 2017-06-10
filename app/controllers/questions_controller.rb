class QuestionsController < ApplicationController
  def index
  	@questions = current_user.questions
  end

  def questions
  end

  def new
    @question = Question.new
    @question.build_answer
  end

  def create
  	@question = current_user.questions.new(question_params)
    (params[:question][:category_ids] || []).each do |category_id|
      @question.question_categories.create(category_id: category_id)
    end
    respond_to do |format|
      if @question.save
        format.html {redirect_to user_question_path(current_user, @question), notice: "Sucessfully created the question"}
      else
        format.html { redirect_to new_user_question_path(current_user), notice: "Enter description and answer" }
      end
    end
  end

  def edit 
  end

  def show
  	@question = Question.find(params[:id])
  end

  def update
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @question = Question.find(params[:id])
    @question.add_or_update_evaluation(:votes, value, current_user)
  end

  private
  def question_params
   params.require(:question).permit(:description,:correct_answer, answer_attributes: [:id, :option1,:option2,:option3,:option4,:_destroy])
  end
end

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
  	question = current_user.questions.create(question_params)
  	redirect_to user_question_path(current_user, question)
  end

  def edit 
  end

  def show
  	@question = Question.find(params[:id])
  end

  def update
  end

  private
  def question_params
   params.require(:question).permit(:description,:correct_answer,:category_ids => [], answer_attributes: [:id, :option1,:option2,:option3,:option4,:_destroy])
  end
end
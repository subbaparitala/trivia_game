class TestsController < ApplicationController
  def new
  	@test = current_user.tests.new
  end

  def create
   test = current_user.tests.new(test_params)
   test.save
   @questions = Question.all.paginate(:page => params[:page], :per_page => 1)
   # @questions = Question.select{|que| que.category_ids.collect{test.category_ids.include?(k)}}
  end
  

  private
  def test_params
    params.require(:test).permit(:category_ids => [])
  end
end

class TestsController < ApplicationController
  def index
     redirect_to request_error_user_tests_path(current_user)
  end

  def new
  	@test = current_user.tests.new
  end

  def create
    begin
      raise 'Session expired'  if request.get? 
      unless  params["test_start"].eql?('true')
        @test = current_user.tests.new(category_ids: (params[:test][:category_ids] rescue []))
        @test.save
      else
        @test = Test.find(params[:test_id])
        question_id = params[:commit] == "Next" ? params[:question_id] : (params[:question_id].to_i - 1)
        @test_data =  @test.test_datums.find_by_question_id(question_id) rescue nil
        if params[:commit] == "Next"
          if @test_data.present?
            @test_data.update_attributes(question_id: question_id, answer_id: params[:test_data])
            @test_data=@test.test_datums.find_by_question_id(question_id.to_i+1)
          else
            test_data = @test.test_datums.new(question_id: question_id,answer_id: params[:test_data])
            test_data.save
          end
          @page = params[:page].to_i + 1
        else
          @page = params[:page].to_i - 1
        end
      end
       @questions = Question.all.paginate(:page => @page, :per_page => 1)
       path = complete_user_test_path(current_user, @test) 
       redirect_to path if (@questions.count).eql?(@page.to_i-1)
    rescue Exception => e
      redirect_to request_error_user_tests_path(current_user)
    end
  end

  def complete
    test = Test.find params[:id]
    @test_datums = test.test_datums
  end

  def request_error
  end
  

  private
  def test_params
    params.require(:test).permit(:category_ids => [])
  end
end

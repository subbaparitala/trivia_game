class TestsController < ApplicationController
 before_filter :authenticate_user!
  # def index
  #    redirect_to request_error_user_tests_path(current_user)
  # end

  def new
  	@test = current_user.tests.new
  end

  def create_test
    begin
      raise 'Session expired'  if request.get?
      unless  params["test_start"].eql?('true')
        @test = current_user.tests.create(test_params.merge!(:test_token=> params[:authenticity_token][0..16]))
        (params[:test][:category_ids] || []).each do |category_id|
          test_categories = @test.test_categories.create(category_id: category_id)
        end
      else
        @test = Test.find(params[:test_id])
        raise 'Authentication failed' unless @test.user_id.eql?(current_user.id) && (params[:token] || params[:test_token]).eql?(@test.test_token)
        question_id = params[:commit] == "Next" ? params[:question_id] : (params[:question_id].to_i - 1)
        question_id = params[:question_id] if params[:test_token].present?
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
        elsif params[:test_token].present?
          @page = params[:page].to_i
        else
          @page = params[:page].to_i - 1
        end
          @test.update_attributes(last_page: @page)
      end
       question_pagination
    rescue Exception => e
      redirect_to request_error_user_tests_path(current_user)
    end
  end

  def complete
    @test = Test.find params[:id]
    @test_datums = @test.test_datums
  end

  def question_pagination
    @questions = Question.all.paginate(:page => @page, :per_page => 1) unless @test.test_categories.present?
    @questions = Question.joins(:question_categories).where("question_categories.category_id IN (?)", 
    @test.test_categories.map(&:category_id)).paginate(:page => @page, :per_page => 1) if @test.test_categories.present?
    path = complete_user_test_path(current_user, @test)
    @test.update_attributes(status: 'pending') 
    if (@questions.count).eql?(@page.to_i-1)
      @test.count_total_marks
      redirect_to path
    end
  end

  def request_error
  end

  def my_tests
    @tests = Test.where(status: 'pending')
    @tests = Test.joins(:test_categories).where('test_categories.category_id IN (?) AND status = ? ',params[:category_ids],'pending') if params[:category_ids].present? 
  end
  

  def vote
    value = params[:type] == "up" ? 1 : -1
    @question = Question.find(params[:id])
    @question.add_evaluation(:votes, value, current_user)
  end

  private
  def test_params
    params.require(:test).permit(:name)
  end
end

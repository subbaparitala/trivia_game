class TestsController < ApplicationController
  def new
  	@test = current_user.tests.new
  end

  def create
   test = current_user.tests.new(test_params)
   test.save
  end
  

  private
  def test_params
    params.require(:test).permit(:category_ids => [])
  end
end

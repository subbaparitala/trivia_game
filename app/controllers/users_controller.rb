class UsersController < ApplicationController 
   def my_results
   	 @tests = current_user.tests.where(status: 'completed')
   	 @tests = current_user.tests.joins(:test_categories).where('test_categories.category_id IN (?) AND status = ? ',params[:category_ids],'completed') if params[:category_ids].present? 
   end

   def all_results
   	@tests = Test.where(status: 'completed')
   	@tests = Test.joins(:test_categories).where('test_categories.category_id IN (?) AND status = ? ',params[:category_ids],'completed') if params[:category_ids].present? 
    if params[:top].present? || params[:less].present? 
			if(params[:top].to_i > 0 or params[:less].to_i > 0 )
			    @tests = @tests.order("total_marks DESC").limit(params[:top]) if params[:top].present? 
				    @tests = @tests.order("total_marks ASC").limit(params[:less]) if params[:less].present?
			else
				   flash[:errors] = "can't choose both no of top and no of less users or don't use nagative value or zero"
			end
		end
   end
end
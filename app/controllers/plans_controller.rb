class PlansController < ApplicationController
 	
 	def create
        @plan = Plan.where("user_id = ? AND organization_id = ?", params[:user_id].to_i, params[:organization_id].to_i)
        if @plan.empty?  
    	   @plan = Plan.new(user_id: params[:user_id].to_i, organization_id: params[:organization_id].to_i)
            if @plan.save
  			   redirect_to "/organizations/#{@plan.organization_id}"
  		    else
  			   flash[:plan_errors] = @plan.errors.full_messages
  			   redirect_to "/organizations/#{@plan.organization_id}"
  		    end
        else
            redirect_to "/organizations/#{@plan.organization_id}"
        end
    end

    def destroy
    	@plan = Plan.where(user: User.find(params[:user_id].to_i), organization: Organization.find(params[:organization_id].to_i)).first
    	if @plan.destroy
      		redirect_to "/organizations/#{@plan.organization_id}"
    	else
      		flash[:destroy_errors] = @plan.errors.full_messages
      		redirect_to "/organizations/#{@plan.organization_id}"
    	end
    end
end

class OrganizationsController < ApplicationController
  
    def index
    	if session[:user_id].nil?
        	redirect_to users_index_path
    	else
    		@user = User.find(session[:user_id])
    		@orgs = Organization.all
    		@org = Organization.new
        	@members = Plan.select("plans.*, users.*").joins("LEFT JOIN users ON users.id = plans.user_id")
        	@plans = User.find(session[:user_id]).plans
        	@memberCount = 0
    	end
    end

    def show
    	@org = Organization.select("organizations.*, users.*").joins("LEFT JOIN users ON users.id = organizations.user_id").where("organizations.id = ?", params[:id]).first
  		@org[:id] = params[:id]
  		@members = Plan.select("plans.*, users.*").joins("LEFT JOIN users ON users.id = plans.user_id").where("plans.organization_id = ?", params[:id].to_i)
    end

    def create
    	@org = Organization.new(name: params[:name], description: params[:description], user_id: params[:user_id])
  		@org[:user_id] = @org[:user_id].to_i
  		if @org.save
  			redirect_to plans_create_path(user_id: @org.user_id, organization_id: @org.id)
  		else
  			flash[:errors] = @org.errors.full_messages
  			redirect_to organizations_index_path
  		end
    end

    def destroy
    	@org = Organization.find(params[:id].to_i)
    	if @org.destroy
    		redirect_to organizations_index_path
    	else
    		flash[:errors] = @org.errors.full_messages
    		redirect_to organizations_index_path
    	end
    end
end

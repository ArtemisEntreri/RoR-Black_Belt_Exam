class SessionsController < ApplicationController
  
  def create
		user = User.authenticate(params[:session][:email], params[:session][:password])
  		if user.nil?
  			flash[:error] = "Could not find a user with that email and password combination"
  			redirect_to users_index_path
  		else
  			session[:user_id] = user.id
  			redirect_to organizations_index_path user
  		end
	end

	def destroy
		session[:user_id] = nil
   		flash[:message] = 'You have successfully logged out'
  		redirect_to users_index_path
    end
end

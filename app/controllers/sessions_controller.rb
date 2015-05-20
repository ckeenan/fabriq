class SessionsController < ApplicationController
    def create
	user = User.find_by(id: params[:id])
	if user
	    sign_in user
	    flash[:success] = "Welcome back, Hiccup!"
	    redirect_to "/main/index"
	else
	    flash.now[:error] = 'Invalid email/password combination'
	    render 'new'
	end
    end

    def destroy
	sign_out
	flash[:success] = "See you again soon!"
	redirect_to root_url
    end
end

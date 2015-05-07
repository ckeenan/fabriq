class MainController < ApplicationController
  def index
  	@top_reps = User.all.order('reputation DESC').limit(5)
  end

  def invite
  	@invite = Invite.new
  end

  def home
  	render :layout => "landing"
  end

  def explore
    
  end
  
end

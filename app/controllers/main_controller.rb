class MainController < ApplicationController
  def index
  	@top_reps = User.all.order('reputation DESC').limit(6)
  	@mystery = User.all.order(:reputation).limit(4)
  end

  def invite
  	@invite = Invite.new
  end
  
end

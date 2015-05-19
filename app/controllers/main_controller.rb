class MainController < ApplicationController
  def index
  	@top_reps = User.all.order('reputation DESC').limit(5)
  end

  def invite
  	@invite = Invite.new
  end

  def home
    
    @newsletter = Newsletter.new
  	render :layout => "landing"
  end

  def explore
    @top_reps = User.all.order('reputation DESC').limit(5)
    @users = User.all
    @array = @users.map{|f| [f.name, f.avatar.to_s, f.id]}
    @arrayb = ["Bryan", "Ashley", "Patrick", "Connor", "Carolyn"]
  end
  
end

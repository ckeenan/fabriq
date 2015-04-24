class MainController < ApplicationController
  def index
  end

  def invite
  	@invite = Invite.new
  end
  
end

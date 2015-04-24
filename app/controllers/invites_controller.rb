class InvitesController < ApplicationController

	def index
	end

	def show
	end

	def new
		@invite = Invite.new
	end

	def edit
	end

	def create
		@invite = Invite.new(invite_params)
		if @invite.save
			@invite.send_invite_email
			flash[:success] = "Invite Sent!"
			redirect_to '/main/index'
		else
			render '/main/index'
		end
	end

	def update
		respond_to do |format|
			if @invite.update(invite_params)
				format.html { redirect_to @invite, notice: 'Invite was successfully updated.' }
				format.json { render :show, status: :ok, location: @invite }
			else
				format.html { render :edit }
				format.json { render json: @invite.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@micropost.destroy
		redirect_to root_url
	end

	private

		def invite_params
			params.require(:invite).permit(:email)
		end
end

class NewslettersController < ApplicationController

	def index
	end

	def show
	end

	def new
		@newsletter = Newsletter.new
	end

	def edit
	end

	def create
		@newsletter = Newsletter.new(newsletter_params)
		if @newsletter.save
			@newsletter.send_newsletter_email
			flash[:success] = "newsletter Sent!"
			redirect_to '/main/home'
		else
			render '/main/home'
		end
	end

	def update
		respond_to do |format|
			if @newsletter.update(newsletter_params)
				format.html { redirect_to '/main/home', notice: 'newsletter was successfully updated.' }
				format.json { render '/main/home', status: :ok, location: @newsletter }
			else
				format.html { render '/main/home' }
				format.json { render json: @newsletter.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@newsletter.destroy
		redirect_to '/main/home'
	end

	private

		def newsletter_params
			params.require(:newsletter).permit(:email)
		end
end

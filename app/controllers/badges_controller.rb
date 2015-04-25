class BadgesController < ApplicationController

	def index
		@badges = Badge.all
	end

	def show
		@badge = Badge.find(params[:id])
	end

	def new
		@badge = Badge.new
	end

	def edit
	end

	def create
		@badge = Badge.new(badge_params)
		if @badge.save
			flash[:success] = "Badge created!"
			redirect_to '/main/index'
		else
			render '/main/index'
		end
	end

	def update
		respond_to do |format|
			if @badge.update(badge_params)
				format.html { redirect_to @badge, notice: 'Badge was successfully updated.' }
				format.json { render :show, status: :ok, location: @badge }
			else
				format.html { render :edit }
				format.json { render json: @badge.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@badge.destroy
		redirect_to root_url
	end

	private

		def badge_params
			params.require(:badge).permit(:name, :icon)
		end
end

class TribesController < ApplicationController

	def index
		@tribes = Tribe.all
	end

	def show
		@tribe = Tribe.find(params[:id])
		@tribals = @tribe.users.all
	end

	def new
		@tribe = Tribe.new
	end

	def edit
	end

	def jointribe
		@current = current_user
		@tribe = Tribe.find(params[:id])
		@current.tribe_id = @tribe.id
		@current.save
		redirect_to @tribe, notice: "Thanks!"
	end

	def create
		@tribe = Tribe.new(tribe_params)
		if @tribe.save
			flash[:success] = "tribe created!"
			redirect_to '/main/index'
		else
			render '/main/index'
		end
	end

	def update
		respond_to do |format|
			if @tribe.update(tribe_params)
				format.html { redirect_to @tribe, notice: 'tribe was successfully updated.' }
				format.json { render :show, status: :ok, location: @tribe }
			else
				format.html { render :edit }
				format.json { render json: @tribe.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@tribe.destroy
		redirect_to root_url
	end

	private

		def tribe_params
			params.require(:tribe).permit(:name, :desc)
		end
end

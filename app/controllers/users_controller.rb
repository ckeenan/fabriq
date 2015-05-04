class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def beamfive
    @current = current_user
    @user = User.find(params[:id])
    @user.reputation = @user.reputation + 5
    @current.reputation = @current.reputation - 5
    @current.save
    @user.save
    redirect_to @user, notice: "Thanks!"
  end

  def beamten
    @current = current_user
    @user = User.find(params[:id])
    @user.reputation = @user.reputation + 10
    @current.reputation = @current.reputation - 10
    @current.save
    @user.save
    redirect_to @user, notice: "Thanks!"
  end

  def beamfif
    @current = current_user
    @user = User.find(params[:id])
    @user.reputation = @user.reputation + 15
    @current.reputation = @current.reputation - 15
    @current.save
    @user.save
    redirect_to @user, notice: "Thanks!"
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "It's a pleasure to meet you!"
      redirect_to "/main/index"
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation, :tribe_id)
    end
end
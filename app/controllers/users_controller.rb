class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :show_lights, :show_places]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # GET /users/1/lights
  def show_lights
    @lights = @user.lights
    if @lights
      render json: @lights
    else
      render json: "Error en users/user_id/lights"
    end
  end

  # GET /users/1/places
  def show_places
    @places = @user.places
    if @places
      render json: @places
    else
      render json: "Error en users/user_id/places"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :token, :email, :password_digest, :password)
    end
end

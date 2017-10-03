class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :update, :destroy, :show_lights]

  # GET /places
  def index
    @places = Place.all

    render json: @places
  end

  # GET /places/1
  def show
    render json: @place
  end

  # POST /places
  def create
    @user = User.find(params[:user_id])
    @place = @user.places.create(place_params)

    if @place.save
      render json: @place, status: :created, location: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy
  end

  # GET /places/1/lights
  def show_lights
    if @place.lights
      render json: @place.lights
    else
      render json: "Error en /places/place_id/lights"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def place_params
      params.require(:place).permit(:name)
    end
end

class LightsController < ApplicationController
  before_action :set_light, only: [:show, :update, :destroy, :show_light_logs]

  # GET /lights
  def index
    @lights = Light.all
    render json: @lights
  end

  # GET /lights/1
  def show
    render json: @light
  end

  # POST /lights
  def create
    @place = Place.find(params[:place_id])
    @light = @place.lights.create(light_params)

    if @light.save
      render json: @light, status: :created, location: @light
    else
      render json: @light.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lights/1
  def update
    if @light.update(light_params)
      render json: @light
    else
      render json: @light.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lights/1
  def destroy
    @light.destroy
  end

  # GET /lights/1/light_logs
  def show_light_logs
    if @light.light_logs
      render json: @light.light_logs
    else
      render json: "Error en /lights/light_id/light_logs"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light
      @light = Light.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def light_params
      params.require(:light).permit(:name, :consumption, :status)
    end
end

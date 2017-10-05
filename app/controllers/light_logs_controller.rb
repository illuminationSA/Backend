class LightLogsController < ApplicationController
  before_action :set_light_log, only: [:show, :update, :destroy]

  # GET /light_logs
  def index
    @light_logs = LightLog.all

    render json: @light_logs
  end

  # GET /light_logs/1
  def show
    render json: @light_log
  end

  # POST /light_logs
  def create
    @light = Light.find(params[:light_id])
    @light_log = @light.light_logs.create(light_log_params)

    if @light_log.save
      render json: @light_log, status: :created, location: @light_log
      @light_log.update_light_consumption
    else
      render json: @light_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /light_logs/1
  def update
    if @light_log.update(light_log_params)
      render json: @light_log
    else
      render json: @light_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /light_logs/1
  def destroy
    @light_log.destroy
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light_log
      @light_log = LightLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def light_log_params
      params.require(:light_log).permit(:event)
    end
end

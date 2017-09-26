class ScheduleTimesController < ApplicationController
  before_action :set_schedule_time, only: [:show, :update, :destroy]

  # GET /schedule_times
  def index
    @schedule_times = ScheduleTime.all

    render json: @schedule_times
  end

  # GET /schedule_times/1
  def show
    render json: @schedule_time
  end

  # POST /schedule_times
  def create
    @light = Light.find(params[:light_id])
    #@schedule_time = ScheduleTime.new(schedule_time_params)
    @schedule_time = @light.schedule_times.create(schedule_time_params)

    if @schedule_time.save
      render json: @schedule_time, status: :created, location: @schedule_time
    else
      render json: @schedule_time.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schedule_times/1
  def update
    if @schedule_time.update(schedule_time_params)
      render json: @schedule_time
    else
      render json: @schedule_time.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schedule_times/1
  def destroy
    @schedule_time.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule_time
      @schedule_time = ScheduleTime.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_time_params
      params.require(:schedule_time).permit(:set_to, :event_time, :light_id)
    end
end

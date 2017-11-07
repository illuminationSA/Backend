class LightsController < ApplicationController
  before_action :set_light, only: [:show, :update, :destroy, :show_light_logs, :graph_data]

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

  # GET /lights/1/light_logs
  def graph_data
    # Declarations
    watts = 20 # Watts for a Saving Light Bulb = 20 w, Incandescent bulb = 100 w
    consumption = 0.0
    duration = 0.0
    today = Date.today
	  @logs_list = @light.light_logs

    # escojer logs hasta hora actual
    # today_logs = @logs_list.where( ["created_at >= ? AND created_at <= ?", today.beginning_of_day, Time.now] )
    # para mostrar todos los logs del día
    today_logs = @logs_list.where( ["created_at >= ? AND created_at <= ?", today.beginning_of_day, today.end_of_day  ] )

    ev_times = {}
    com = {}

    today_logs.each do |single|
      ev_times[single.created_at.strftime("%H%M%S").to_i] = [single.event, single.created_at]
    end

    # Hash[ev_times.sort]

    times_keys = ev_times.keys
    times_keys.sort

    puts "size: " + times_keys.size.to_s
    #puts ev_times[ times_keys[times_keys.size - 1] ][0]
    puts "time now: " + Time.now.strftime("%H%M%S")
    puts "bg d: " + today.beginning_of_day.to_s

    count = 0

    if times_keys.length > 0
      if ev_times[ times_keys[0] ][0] == false
        ev_times[ 0 ] = [ true, today.beginning_of_day ]
      end
      if ev_times[ times_keys[times_keys.size - 1] ][0] == true
        ev_times[ Time.now.strftime("%H%M%S").to_i ] = [ true, today.beginning_of_day ]
      end
    end

    times_keys.each do |tk|
      teim = tk

      # teim = Time.now.strftime("%H%M%S").to_i
      # teim = "000500".to_i
      hora = teim / 10000
      minutos = (teim / 100) - hora * 100
      segundos = teim - hora * 10000 - minutos * 100

      puts hora.to_s + ":" + minutos.to_s + ":" + segundos.to_s
      dece = (minutos / 10).to_i
      uni = (minutos - dece * 10).to_i
      puts "dec: " + dece.to_s + " uni: "+ uni.to_s
      # puts (uni >= 5 && uni < 7) || (uni = 7 && segundos < 30)
      # puts "3 " + (uni = 7 && segundos < 30).to_s
      # puts uni

      # puts (uni < 2 || uni == 2 && segundos < 30)
      # puts ( ( uni < 5 && uni > 2 ) || (uni == 2 && segundos >= 30 ) )
      # puts ( ( uni >= 5 && uni < 7 ) || (uni == 7 && segundos < 30 ) )
      # puts ( uni > 7 || uni == 7 && segundos >= 30 )

      if (uni < 2 || uni == 2 && segundos < 30)
        segundos = 0
        minutos = dece * 10
      end
      if ( ( uni < 5 && uni > 2 ) || (uni == 2 && segundos >= 30 ) )
        segundos = 0
        minutos = dece * 10 + 5
      end
      if ( ( uni >= 5 && uni < 7 ) || (uni == 7 && segundos < 30 ) )
        segundos = 0
        minutos = dece * 10 + 5
      end
      if ( uni > 7 || uni = 7 && segundos >= 30 )
        segundos  = 0
        if (dece * 10 + 10 >= 60)
          hora = hora + 1
          minutos = 0
        else
          minutos = dece * 10 + 10
        end
      end
      dece = (minutos / 10).to_i
      uni = (minutos - dece * 10).to_i
      the_id = hora * 12 + minutos / 5
      puts hora.to_s + ":" + minutos.to_s + ":" + segundos.to_s + " id: " + the_id.to_s

      com[tk] = [hora.to_s + dece.to_s + uni.to_s + (segundos/10).to_i.to_s + (segundos - (segundos/10).to_i * 10).to_i.to_s, the_id]


      # time -> beggining

      # teim1 = today.beginning_of_day

      # position x hour

      # (1..24).each do
      #   (1..12).each do
      #     puts "[" + count.to_s + "] = " +  teim1.to_s
      #     teim1 = teim1 + 5*60
      #     count += 1
      #   end
      # end
    end

    render json: ev_times

	  # if @logs_list.length > 1  # Size of log list > 1
    #   u_log = @logs_list[-1] # Ultimate log
	  # 	p_log = @logs_list[-2] # Penultimate log
	  # 	u_date = @logs_list[-1].created_at.localtime # Date of ultimate log
	  # 	p_date = @logs_list[-2].created_at.localtime # Date of penultimate log
    #   puts 'p_date = ', p_date
    #   puts 'u_date = ', u_date
	  # 	if u_date.to_date == p_date.to_date  # The day didn't change
    #     puts 'The day didnt change'
    #     consumption = @light.consumption
    #     if u_log.event == false # If ultimate log is false, calculate consumption
    #       duration = (u_date - p_date) / 3600
    #       consumption = consumption + (watts * duration)
    #       @light.update_attribute(:consumption, consumption)
    #     end
    #   else # The day changed
    #     puts 'The day changed'
    #     if u_log.event == false # If ultimate log is false, calculate consumption
    #       b_date = u_date.beginning_of_day.localtime
    #       puts 'b_date = ', b_date
    #       puts 'u_date = ', u_date
    #       duration = (u_date - b_date) / 3600
    #       consumption = (watts * duration)
    #       @light.update_attribute(:consumption, consumption)
    #     else # If ultimate log is true, restart consumption
    #       consumption = 0.0
    #     end
    #   end
    #   puts 'duration = ', duration
    #   puts 'consumption = ', consumption
    # else
    #   puts 'One light registered'
    # end
  end #

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

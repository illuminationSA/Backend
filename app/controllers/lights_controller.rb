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
    # duration = 0.0
    today = Date.today
	  @logs_list = @light.light_logs

    # creación arreglo y llenado de 0's
    g_data = []
    (0..287).each do |i|
      g_data.push(0)
    end

    # escojer logs hasta hora actual
    today_logs = @logs_list.where( ["created_at >= ? AND created_at <= ?", today.beginning_of_day, Time.now] )
    # para mostrar todos los logs del día
    # today_logs = @logs_list.where( ["created_at >= ? AND created_at <= ?", today.beginning_of_day, today.end_of_day  ] )

    ev_times = {}
    com = {}

    #agregar llaves con el formato HHMMSS y valor [ evento(encendido o apagado), hora del evento ]
    today_logs.each do |single|
      ev_times[single.created_at.strftime("%H%M%S").to_i] = [single.event, single.created_at]
    end

    # Hash[ev_times.sort]
    #times keys = arreglo con las llaves del hash ev_times
    times_keys = ev_times.keys
    #se ordena times keys para tener las horas de forma ascendente
    times_keys.sort


    puts "size: " + times_keys.size.to_s
    #puts ev_times[ times_keys[times_keys.size - 1] ][0]
    puts "time now: " + Time.now.strftime("%H%M%S")
    puts "bg d: " + today.beginning_of_day.to_s

    count = 0
    # se agrega un evento on a las 0000000 si el primer evento es un off
    # también un off en el momento de la consulta para realizar el cálculo hasta ese momento si la luz se encuentra encendida (el último registro es un ON)
    if times_keys.length > 0
      if ev_times[ times_keys[0] ][0] == false
        ev_times[ 0 ] = [ true, today.beginning_of_day ]
      end
      if ev_times[ times_keys[times_keys.size - 1] ][0] == true
        ev_times[ Time.now.strftime("%H%M%S").to_i ] = [ true, Time.now ]
      end
    end

    #por cada llave se calcula su posición en el arreglo de datos
    times_keys.each do |tk|
      teim = tk

      hora = teim / 10000
      minutos = (teim / 100) - hora * 100
      segundos = teim - hora * 10000 - minutos * 100

      # puts hora.to_s + ":" + minutos.to_s + ":" + segundos.to_s
      dece = (minutos / 10).to_i
      uni = (minutos - dece * 10).to_i
      # puts "dec: " + dece.to_s + " uni: "+ uni.to_s

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

    end

    #se calcula el consumo en cada punto de la gráfica / Cada 5 minutos
    current_consumption = 0
    c_on_id = 0
    c_off_id = 1
    last_id = 0

    (0..(com.length/2)-1).each do |p_on|
      # id's de cada hora en el arreglo de puntos de la gráfica
      id_on = com[times_keys[c_on_id]][1]
      id_off = com[times_keys[c_off_id]][1]
      # hora de tipo Time en la que sucedió el evento
      h_on = ev_times[times_keys[c_on_id]][1]
      h_off = ev_times[times_keys[c_off_id]][1]

      #puts h_on.to_s + " "+ h_off.to_s
      # Tiempo de consumo
      t_on = h_off - h_on
      # Consumo en watts
      i_consumption = t_on/3600 * watts

      #rellenar de consumo actual los campos desde el último apagado
      (last_id...id_on).each do |fill|
        g_data[ fill ] = current_consumption
      end

      #agregar los puntos desde el encendido hasta el apagado dependiendo del tiempo total de encendido
      if id_off - id_on > 1
        each_consumption = i_consumption / (id_off - id_on)
        (0...(id_off - id_on)).each do |i|
          # puts "Consumption here " + i.to_s + " " + (current_consumption+each_consumption*i).to_s
          #Se agrega cada porción de consumo en current_consumption
          g_data[ id_on + i ] = current_consumption + each_consumption * i
        end
      else
        #se agrega el consumo en el tiempo calculado al current_consumption
        g_data[ id_off ] = current_consumption + i_consumption
      end

      # aumentar consumo
      current_consumption += i_consumption

      # puts "Consumo: " + current_consumption.to_s

      # aumentar contadores
      last_id = id_off
      c_on_id += 2
      c_off_id += 2
    end

    if last_id < 287
      (last_id...288).each do |fill|
        #llenar los puntos restantes con current_consumption
        g_data[ fill ] = current_consumption
      end
    end

    # (0...g_data.length).each do |j|
    #   # puts g_data[j].to_s
    #   puts "[" + j.to_s + "]" + " = " + g_data[j].to_s
    # end
    # puts "lenght gdata: " + g_data.length.to_s
    # render json: ev_times

    teim1 = today.beginning_of_day

    # position x hour

    # (1..24).each do
    #   (1..12).each do
    #     puts "[" + count.to_s + "] = " +  teim1.to_s
    #     teim1 = teim1 + 5*60
    #     count += 1
    #   end
    # end

    final = []
    (0...g_data.length).each do |j|
      final.push( { 'data' => g_data[j],
        'caption' => teim1.strftime("%H:%M:%S") }  )
      teim1 = teim1 + 5*60
    end

    # (0...24).each do |cap|
    #   final[ 12 * cap ] = { 'data' => g_data[ 12 * cap ],
    #     'caption' => cap.to_s}
    # end
    render json: final

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

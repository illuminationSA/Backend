class LightLog < ApplicationRecord
  belongs_to :light

  def self.load
    includes( :light)
  end

  def self.by_id( light_log_id )
    load.find_by( {id: light_log_id} )
  end

  def self.by_light( light_id )
    load.where( {light_id: light_id} )
  end

  # updates the consumption of it's light
  def update_light_consumption
  	@tmp = LightLog.by_light(self.light_id)
  	@light = Light.by_id(self.light_id)
  	consumption = @light.consumption
  	puts "initial consumption: #{ consumption }."
  	puts "event for last: #{ @tmp[-1].event }."
  	if not @tmp[-1].event
	  	hours_day = ((@tmp[-1].created_at - @tmp[-2].created_at) / 3600)
	  	watts = 20 #Watts for a Saving Light Bulb = 20 w, Incandescent bulb = 100 w
	  	consumption = consumption + (watts * hours_day)
	    @light.update_attribute(:consumption, consumption)
	    puts 'updated...'
	else
		puts 'not updated because you are a ON action'
	end
    puts "last consumption: #{ consumption }."
  end

end

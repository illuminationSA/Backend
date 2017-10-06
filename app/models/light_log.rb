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
  	if not self.event
	  	@tmp = LightLog.by_light(self.light_id)
	  	if @tmp.length > 1
	  		last = @tmp[-1]
	  		llast = @tmp[-2]
	  		last_date = @tmp[-1].created_at
	  		llast_date = @tmp[-2].created_at
	  		@light = Light.by_id(self.light_id)
	  		if last_date.to_date == llast_date.to_date
			  	@light = Light.by_id(self.light_id)
			  	consumption = @light.consumption
			  	hours_day = ((last_date - llast_date) / 3600)
			  	puts hours_day 
			  	watts = 20 #Watts for a Saving Light Bulb = 20 w, Incandescent bulb = 100 w
			  	consumption = consumption + (watts * hours_day)
			    @light.update_attribute(:consumption, consumption)
			    puts 'updated...'
			else
#caso 1
		#...
		#...
		#...
#llast	true  6/10 09:00 PM   true  6/10 9:00 PM    true  6/10 09:00  PM
#last	false 7/10 06:00 AM   false 7/10 6:00 AM    false 6/10 11:59  PM
# 							  false 7/10 6:00 AM    true  7/10 00:00  AM    consumo 0.0
# 							  false 7/10 6:00 AM    false 7/10 06:00  AM    consumo ++

#caso 2
		#...
		#...
		#...
#llast	false 6/10 09:00 PM   false 6/10 9:00 PM
#last	true  7/10 06:00 AM   true  7/10 6:00 AM    true  6/10 11:59  AM
#		              		  true  7/10 6:00 AM    false 7/10 00:00  AM  consumo 0.0
#		                      true  7/10 6:00 AM    true  7/10 06:00  AM
				puts last_date.to_date
				LightLog.last.update_attribute(:created_at , last_date.change( day:last_date.to_date))
#
				#LightLog.last.update_attribute(:created_at , last_date.change( {hour: 23, min: 59, sec: 59} ))
				#LightLog.last.update_attribute(:event, last.event)
				#LightLog.last.update_attribute(:created_at, last_date.change( {day:last_date.prev_day} ))
		    	#LightLog.create(:event => (not last.event), :light_id => last.light_id)
		    	#LightLog.last.update_attribute(:created_at => last_date.change({ hour: 0 }))
		    	#@light.update_attribute(:consumption, 0.0)
		    	#LightLog.create(:event => last.event, :light_id => last.light_id)
		    	#LightLog.last.update_attribute(:created_at => last.created_at)
				#@light.update_attribute(:consumption, (20 * ((last_date - llast_date) / 3600)))
			end
		else
			puts 'not updated because you are the first light log for your ligth'
		end	
	else
		puts 'not updated because you are a ON action'
	end
  end

end

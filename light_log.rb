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

  # Updates the consumption for a light
  def update_light_consumption
    # Declarations
    watts = 20 # Watts for a Saving Light Bulb = 20 w, Incandescent bulb = 100 w
    consumption = 0.0
    duration = 0.0
    @light = Light.by_id(self.light_id) # Light id
	  @logs_list = LightLog.by_light(self.light_id)

	  if @logs_list.length > 1  # Size of log list > 1
      u_log = @logs_list[-1] # Ultimate log
	  	p_log = @logs_list[-2] # Penultimate log
	  	u_date = @logs_list[-1].created_at.localtime # Date of ultimate log
	  	p_date = @logs_list[-2].created_at.localtime # Date of penultimate log
      puts 'p_date = ', p_date
      puts 'u_date = ', u_date
	  	if u_date.to_date == p_date.to_date  # The day didn't change
        puts 'The day didnt change'
        consumption = @light.consumption
        if u_log.event == false # If ultimate log is false, calculate consumption
          duration = (u_date - p_date) / 3600
          consumption = consumption + (watts * duration)
          @light.update_attribute(:consumption, consumption)
        end
      else # The day changed
        puts 'The day changed'
        if u_log.event == false # If ultimate log is false, calculate consumption
          b_date = u_date.beginning_of_day.localtime
          puts 'b_date = ', b_date
          puts 'u_date = ', u_date
          duration = (u_date - b_date) / 3600
          consumption = (watts * duration)
          @light.update_attribute(:consumption, consumption)
        else # If ultimate log is true, restart consumption
          consumption = 0.0
        end
      end
      puts 'duration = ', duration
      puts 'consumption = ', consumption
    else
      puts 'One light registered'
    end
  end # End of function

end

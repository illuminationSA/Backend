class ScheduleTime < ApplicationRecord
  belongs_to :light

  def self.load
    includes( :light)
  end

  def self.by_id( schedule_time_id )
    load.find_by( {id: schedule_time_id} )
  end

  def self.by_light( light_id )
    load.where( {light_id: light_id} )
  end
end

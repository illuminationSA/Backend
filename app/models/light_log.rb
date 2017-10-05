class LightLog < ApplicationRecord
  belongs_to :light

  def self.load
    includes( :light)
  end

  def self.by_id( light_log_id )
    load.find_by( {id: light_log_id} )
  end


end

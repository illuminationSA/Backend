class Light < ApplicationRecord
  belongs_to :place
  has_many :light_logs, dependent: :destroy
  has_many :schedule_times, dependent: :destroy

  def self.load
    includes( :place, place: [:user] )
  end

  def self.by_id( light_id )
    load.find_by( {id: light_id} )
  end

  def self.by_ids( ids )
    Light.find( ids )
  end

  def self.by_place(place_id)
    where( {place_id: place_id} )
  end

  def self.by_user( user_id )
    @user = load.place.user_id
  end
end

class Place < ApplicationRecord
  belongs_to :user
  has_many :lights, dependent: :destroy

  def self.load
    includes(:user)
  end

  def self.by_id( place_id )
    find_by( {id: place_id} )
  end

  def self.by_user(user_id)
    load.where( {user_id: user_id} )
  end
end

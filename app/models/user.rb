class User < ApplicationRecord
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  has_secure_password
  has_secure_token
  has_many :places, dependent: :destroy

  # This method is not available in has_secure_token
  def invalidate_token
    self.update_columns(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end

  def self.by_id( user_id )
    self.find_by( {id: user_id} )
  end

  def self.by_email( user_email )
    self.find_by( {email: user_email} )
  end

  def lights
    @lights = Array.new
    self.places.each do |pl|
      pl.lights.each do |li|
        @lights.push( li.id )
      end
    end
    Light.by_ids( @lights )
  end

  def total_consumption
    @total = 0.0
    self.lights.each do |l|
      @total = @total + l.consumption
    end
    return @total
  end

end

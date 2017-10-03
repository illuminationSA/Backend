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

  def lights
    @lights = Array.new
    self.places.each do |pl|
      pl.lights.each do |li|
        @lights.push( li.id )
      end
    end
    Light.by_ids( @lights )
  end

end

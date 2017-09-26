class User < ApplicationRecord
  has_many :places, dependent: :destroy
end

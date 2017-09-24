class Place < ApplicationRecord
  belongs_to :user
  has_many :lights, dependent: :destroy
end

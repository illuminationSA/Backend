class Light < ApplicationRecord
  belongs_to :place
  has_many :light_logs, dependent: :destroy
  has_many :schedule_times, dependent: :destroy
end

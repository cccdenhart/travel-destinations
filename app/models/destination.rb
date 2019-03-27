class Destination < ApplicationRecord
  validates :lat, presence: true
  validates :long, presence: true
end

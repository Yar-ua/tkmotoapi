class Fuel < ApplicationRecord
  belongs_to :bike

  validates :bike, presence: true

  validates :odometer, 
            :distance, 
            :refueling, 
            :price_fuel, length: { maximum: 8, message: "Value must have 10 symbols max" }
  validates :odometer, 
            :distance,
            :refueling,
            :price_fuel, numericality: { message: "Enter digits, not text" }
  validates :odometer, 
            :distance, 
            :refueling,
            :price_fuel, numericality: { greater_than_or_equal_to: 0 }
end

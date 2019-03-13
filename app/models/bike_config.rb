class BikeConfig < ApplicationRecord
  belongs_to :bike

  validates :oil_change, presence: true
  validates :oil_change, numericality: { greater_than_or_equal_to: 0 }
end

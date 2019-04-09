class Oil < ApplicationRecord
  belongs_to :bike

  validates :oil_distance, numericality: { greater_than_or_equal_to: 0 }

end

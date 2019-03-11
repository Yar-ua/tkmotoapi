class Repair < ApplicationRecord
  belongs_to :bike

  validates :bike, presence: true
  validates :description, :detail, length: { maximum: 4000, message: 'Description maximum is 4000 symbols'}
  validates :price_detail, numericality: { greater_than_or_equal_to: 0 }
end

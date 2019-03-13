class Bike < ApplicationRecord
  belongs_to :user

  has_one  :bike_config
  has_many :fuels
  has_many :repairs

  validates :name, presence: { message: "" }
  validates :name, length: { maximum: 30, message: "Enter bike model, 30 symbols max" }
  validates :volume, presence: { message: "Enter engine volume, ccm3" }
  validates :year, presence: { message: "Enter produsing bike year" }
  validates :color, length: { maximum: 20, message: "Enter color" }

end

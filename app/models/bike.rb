class Bike < ApplicationRecord
  belongs_to :user

  has_one  :bike_config, dependent: :destroy
  has_many :fuels, dependent: :destroy
  has_many :repairs, dependent: :destroy
  has_many :oils, dependent: :destroy

  validates :name, presence: { message: "" }
  validates :name, length: { maximum: 30, message: "Enter bike model, 30 symbols max" }
  validates :volume, presence: { message: "Enter engine volume, ccm3" }
  validates :year, presence: { message: "Enter produsing bike year" }
  validates :color, length: { maximum: 20, message: "Enter color" }

end

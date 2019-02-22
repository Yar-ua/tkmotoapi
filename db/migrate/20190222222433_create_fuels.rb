class CreateFuels < ActiveRecord::Migration[5.2]
  def change
    create_table :fuels do |t|
      t.numeric   :odometer
      t.numeric   :distance
      t.numeric   :refueling
      t.numeric   :price_fuel

      t.references :bike, foreign_key: true

      t.timestamps
    end
  end
end

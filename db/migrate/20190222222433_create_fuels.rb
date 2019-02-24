class CreateFuels < ActiveRecord::Migration[5.2]
  def change
    create_table :fuels do |t|
      t.float   :odometer, null: false
      t.float   :distance, null: false
      t.float   :refueling, null: false
      t.float   :price_fuel, null: false

      t.references :bike, foreign_key: true

      t.timestamps
    end
  end
end

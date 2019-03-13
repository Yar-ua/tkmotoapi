class CreateBikeConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :bike_configs do |t|
      t.float :oil_change, default: nil

      t.references :bike, foreign_key: true
      
      t.timestamps
    end
  end
end

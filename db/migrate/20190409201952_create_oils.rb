class CreateOils < ActiveRecord::Migration[5.2]
  def change
    create_table :oils do |t|

      t.integer :oil_distance, default: 0

      t.belongs_to :bike, foreign_key: true

      t.timestamps
    end
  end
end

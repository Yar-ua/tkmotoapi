class CreateRepairs < ActiveRecord::Migration[5.2]
  def change
    create_table :repairs do |t|
      t.text  :description
      t.text  :detail
      t.float :price_detail

      t.references :bike, foreign_key: true

      t.timestamps
    end
  end
end

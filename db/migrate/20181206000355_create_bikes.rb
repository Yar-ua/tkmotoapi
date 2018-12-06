class CreateBikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bikes do |t|

      t.string :name
      t.integer :volume
      t.integer :year
      t.string :color

      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateUserConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_configs do |t|
      t.text :language, default: 'en'

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

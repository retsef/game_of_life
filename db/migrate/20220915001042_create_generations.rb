class CreateGenerations < ActiveRecord::Migration[7.0]
  def change
    create_table :generations do |t|
      t.belongs_to :simulation, null: false, foreign_key: true
      t.integer :number, default: 0, null: false

      t.timestamps
    end
  end
end

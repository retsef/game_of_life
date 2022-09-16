class CreateCells < ActiveRecord::Migration[7.0]
  def change
    create_table :cells do |t|
      t.belongs_to :world, null: false, foreign_key: true
      t.integer :x
      t.integer :y
      t.boolean :alive, default: false

      t.timestamps
    end
  end
end

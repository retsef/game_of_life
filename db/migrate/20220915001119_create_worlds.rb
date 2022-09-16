class CreateWorlds < ActiveRecord::Migration[7.0]
  def change
    create_table :worlds do |t|
      t.belongs_to :generation, null: false, foreign_key: true
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end

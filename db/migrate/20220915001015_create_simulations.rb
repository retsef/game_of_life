class CreateSimulations < ActiveRecord::Migration[7.0]
  def change
    create_table :simulations do |t|
      t.integer :generations_count, default: 0, null: false
      t.datetime :running_at, null: true
      t.datetime :latest_run_at, null: true

      t.timestamps
    end
  end
end

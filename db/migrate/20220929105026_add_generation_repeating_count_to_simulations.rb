class AddGenerationRepeatingCountToSimulations < ActiveRecord::Migration[7.0]
  def change
    add_column :simulations, :generation_repeating_count, :integer, default: 0
  end
end

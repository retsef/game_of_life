# == Schema Information
#
# Table name: simulations
#
#  id                :integer          not null, primary key
#  generations_count :integer          default(0), not null
#  running_at        :datetime
#  latest_run_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Simulation < ApplicationRecord
  # after_update_commit ->(simulation) { broadcast_replace_to simulation, partial: 'simulations/update' }
  # after_update_commit ->(simulation) { broadcast_replace_later_to "current_generation_simulation_#{simulation.id}" }

  has_many :generations, -> { order(number: :desc) }, dependent: :destroy
  has_one :latest_generation, -> { order(number: :desc) }, class_name: 'Generation'
  has_one :previous_generation, -> { order(number: :desc).offset(1) }, class_name: 'Generation'
  has_one :world, through: :latest_generation

  delegate :number, to: :latest_generation, prefix: true, allow_nil: true

  def running?
    running_at.present?
  end

  def next!
    generations.create(number: (latest_generation_number + 1), world: latest_generation.next)
  end

  def repeated?
    generation_repeating_count > repeating_limit
  end

  def repeated!
    update(generation_repeating_count: generation_repeating_count + 1)
  end

  def repeating?
    return false if generations.size < 2

    generations.includes(world: :cells).limit(repeating_offset)
               .collect { |generation| generation.world.to_s }
               .uniq.size < repeating_offset
  end

  def repeating_offset
    4
  end

  def repeating_limit
    5
  end
end

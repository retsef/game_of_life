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
  broadcasts
  # after_update_commit ->(simulation) { broadcast_replace_later_to "current_generation_simulation_#{simulation.id}" }

  has_many :generations, -> { ordered }, dependent: :destroy
  has_one :latest_generation, -> { order(number: :desc) }, class_name: 'Generation'
  has_one :world, through: :latest_generation

  delegate :number, to: :latest_generation, prefix: true, allow_nil: true

  def running?
    running_at.present?
  end

  def next!
    generations.create(number: (latest_generation_number + 1), world: latest_generation.next)
  end
end

# == Schema Information
#
# Table name: generations
#
#  id            :integer          not null, primary key
#  simulation_id :integer          not null
#  number        :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Generation < ApplicationRecord
  # Append new generation to the list
  after_create_commit lambda { |generation|
    broadcast_prepend_to generation.simulation,
                        target: "list_generations_simulation_#{generation.simulation_id}",
                        partial: 'generations/generation'
  }

  belongs_to :simulation, touch: true, counter_cache: true
  has_one :world, dependent: :destroy
  has_many :cells, -> { ordered }, through: :world

  scope :for_simulation, ->(simulation) { where(simulation: simulation) }
  scope :ordered, -> { order(number: :asc) }

  validates :number, numericality: { greater_than_or_equal_to: 0 }
  # validates :number, numericality: { greater_than: :latest_generation_number }, if: -> { simulation.present? || latest_generation_number.present? }

  delegate :width, :height, to: :world, prefix: true
  delegate :latest_generation_number, to: :simulation

  # Return the world of the next generation
  def next
    new_world = World.new(width: world_width, height: world_height)

    cells.each do |cell|
      new_world.cells.build(x: cell.x, y: cell.y, alive: cell.life?)
    end

    new_world
  end
end

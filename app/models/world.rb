# == Schema Information
#
# Table name: worlds
#
#  id            :integer          not null, primary key
#  generation_id :integer          not null
#  width         :integer
#  height        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class World < ApplicationRecord
  belongs_to :generation
  has_one :simulation, through: :generation
  has_many :cells, -> { ordered }, dependent: :destroy

  validates :generation_id, uniqueness: true
  validates :width, numericality: { greater_than: 0 }
  validates :height, numericality: { greater_than: 0 }

  with_options if: -> { simulation_world.present? } do
    validates :width, comparison: { equal_to: :simulation_world_width }
    validates :height, comparison: { equal_to: :simulation_world_height }
  end

  delegate :width, :height, to: :simulation_world, prefix: true, allow_nil: true

  def simulation_world
    simulation.world
  end

  def self.empty(width: 0, height: 0)
    new(width: width, height: height).tap do |world|
      width.times do |x|
        height.times do |y|
          world.cells.build(x: x, y: y)
        end
      end
    end
  end

  def to_s
    cells.collect { |cell| cell.alive? ? '*' : '.' }.in_groups_of(width).collect(&:join).join('\n')
  end
end

# == Schema Information
#
# Table name: cells
#
#  id         :integer          not null, primary key
#  world_id   :integer          not null
#  x          :integer
#  y          :integer
#  alive      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cell < ApplicationRecord
  belongs_to :world
  has_one :generation, through: :world

  scope :ordered, -> { order(x: :asc, y: :asc) }
  scope :neighbors, ->(cell) { where(world: cell.world).where(x: [cell.x - 1, cell.x + 1]).where(y: [cell.y - 1, cell.y + 1]) }
  scope :alive, -> { where(alive: true) }
  scope :death, -> { where(alive: false) }

  delegate :width, :height, to: :world, prefix: true

  validates :x, numericality: { greater_than_or_equal_to: 0 }
  validates :y, numericality: { greater_than_or_equal_to: 0 }

  # validates :x, numericality: { less_than: :world_width }
  # validates :y, numericality: { less_than: :world_height }
  # validates :x, :y, uniqueness: { scope: :world_id }

  def neighbors_alive
    @neighbors_alive ||= self.class.neighbors(self).alive.size
  end

  def death?
    !alive?
  end

  # Check if should be death or alive
  def life?
    if alive?
      return false if neighbors_alive >= 3
      return true if [2, 3].include? neighbors_alive
      return false if neighbors_alive <= 2
    end

    return true if neighbors_alive == 3

    false
  end

  def flip!
    toggle!(:alive)
  end

  def flip
    toggle(:alive)
  end
end

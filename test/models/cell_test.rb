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
require "test_helper"

class CellTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

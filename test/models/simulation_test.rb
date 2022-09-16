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
require "test_helper"

class SimulationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

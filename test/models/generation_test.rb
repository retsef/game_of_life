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
require "test_helper"

class GenerationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

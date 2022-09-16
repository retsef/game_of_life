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
require "test_helper"

class WorldTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

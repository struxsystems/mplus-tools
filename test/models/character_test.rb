# == Schema Information
#
# Table name: characters
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)
#  raider_io_pull  :datetime
#  name            :string
#  realm           :string
#  region          :string
#  raider_io_score :integer
#  item_level      :integer
#  verified        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  thumbnail_url   :string
#  guild           :string
#

require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

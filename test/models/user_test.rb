# == Schema Information
#
# Table name: users
#
#  id          :bigint(8)        not null, primary key
#  battletag   :string
#  email       :string
#  password    :string
#  access_code :string
#  phone       :string
#  verified    :boolean
#  settings    :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  discord_id  :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

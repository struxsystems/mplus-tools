# == Schema Information
#
# Table name: runs
#
#  id                  :bigint(8)        not null, primary key
#  start               :datetime
#  expire              :datetime
#  instance            :integer
#  description         :text
#  min_raider_io_score :integer
#  min_item_level      :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Run < ApplicationRecord
end

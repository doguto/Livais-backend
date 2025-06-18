# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_follows_on_followed_id  (followed_id)
#  index_follows_on_follower_id  (follower_id)
#

require "test_helper"

class FollowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: replies
#
#  id             :integer          not null, primary key
#  parent_post_id :integer          not null
#  child_post_id  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_replies_on_child_post_id   (child_post_id)
#  index_replies_on_parent_post_id  (parent_post_id)
#

require "test_helper"

class ReplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: reposts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reposts_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#

require "test_helper"

class RepostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

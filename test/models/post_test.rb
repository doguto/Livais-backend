# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  content        :string(280)
#  likes_count    :integer          default(0), not null
#  quotes_count   :integer          default(0), not null
#  replies_count  :integer          default(0), not null
#  reposts_count  :integer          default(0), not null
#  status         :string           default("published")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  quoted_post_id :bigint
#  reply_to_id    :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_posts_on_quoted_post_id  (quoted_post_id)
#  index_posts_on_reply_to_id     (reply_to_id)
#  index_posts_on_user_id         (user_id)
#
# Foreign Keys
#
#  quoted_post_id  (quoted_post_id => posts.id)
#  reply_to_id     (reply_to_id => posts.id)
#  user_id         (user_id => users.id)
#
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

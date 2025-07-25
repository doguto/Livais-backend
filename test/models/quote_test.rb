# == Schema Information
#
# Table name: quotes
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  quoted_post_id  :bigint           not null
#  quoting_post_id :bigint           not null
#
# Indexes
#
#  index_quotes_on_quoted_post_id   (quoted_post_id)
#  index_quotes_on_quoting_post_id  (quoting_post_id)
#
# Foreign Keys
#
#  quoted_post_id   (quoted_post_id => posts.id)
#  quoting_post_id  (quoting_post_id => posts.id)
#

require "test_helper"

class QuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

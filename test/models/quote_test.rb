# == Schema Information
#
# Table name: quotes
#
#  id              :integer          not null, primary key
#  quoted_post_id  :integer          not null
#  quoting_post_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_quotes_on_quoted_post_id   (quoted_post_id)
#  index_quotes_on_quoting_post_id  (quoting_post_id)
#

require "test_helper"

class QuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

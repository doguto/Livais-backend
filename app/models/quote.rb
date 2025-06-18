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

class Quote < ApplicationRecord
  belongs_to :quoted_post, class_name: "Post"
  belongs_to :quoting_post, class_name: "Post", inverse_of: :quote_post
end

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

class Quote < ApplicationRecord
  belongs_to :quoted_post, class_name: "Post"
  belongs_to :quoting_post, class_name: "Post", inverse_of: :quote
  has_one :notice, as: :notifiable, dependent: :destroy

  after_create :create_notification

  def create_notification
    Notice.create!(user_id: quoted_post.user_id, notifiable: self)
  end
end

# == Schema Information
#
# Table name: replies
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  child_post_id  :bigint           not null
#  parent_post_id :bigint           not null
#
# Indexes
#
#  index_replies_on_child_post_id   (child_post_id)
#  index_replies_on_parent_post_id  (parent_post_id)
#
# Foreign Keys
#
#  child_post_id   (child_post_id => posts.id)
#  parent_post_id  (parent_post_id => posts.id)
#

class Reply < ApplicationRecord
  belongs_to :parent_post, class_name: "Post", inverse_of: :child_replies
  belongs_to :child_post, class_name: "Post", inverse_of: :parent_reply
  has_one :notice, as: :notifiable, dependent: :destroy

  after_create :create_notification

  def create_notification
    Notice.create!(user_id: parent_post.user_id, notifiable: self)
  end
end

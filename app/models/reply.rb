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

class Reply < ApplicationRecord
  belongs_to :parent_post, class_name: "Post", inverse_of: :child_replies
  belongs_to :child_post, class_name: "Post", inverse_of: :parent_reply

  after_create :create_notification

  def create_notification
    Notice.create!(user_id: parent_post.user_id, notifiable: self)
  end
end

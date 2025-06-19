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

class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", inverse_of: :followee_relationships
  belongs_to :followed, class_name: "User", inverse_of: :follower_relationships
  has_one :notifiable, as: :notifiable, dependent: :destroy

  after_create :create_notification

  def create_notification
    Notice.create(user_id: followed_id, notifiable: self)
  end
end

# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :bigint
#  follower_id :bigint
#
# Indexes
#
#  index_follows_on_followed_id  (followed_id)
#  index_follows_on_follower_id  (follower_id)
#
# Foreign Keys
#
#  followed_id  (followed_id => users.id)
#  follower_id  (follower_id => users.id)
#

class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", inverse_of: :followee_relationships
  belongs_to :followed, class_name: "User", inverse_of: :follower_relationships
  has_one :notice, as: :notifiable, dependent: :destroy

  after_create :create_notification

  def create_notification
    Notice.create!(user_id: followed_id, notifiable: self)
  end
end

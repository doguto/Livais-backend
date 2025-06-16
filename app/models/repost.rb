class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_one :notifiable, as: :notifiable, dependent: :destroy

  after_create :create_notification

  def create_notification
    Notice.create(user_id: post.user_id, notifiable: self)
  end
end

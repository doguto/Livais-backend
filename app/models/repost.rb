# == Schema Information
#
# Table name: reposts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reposts_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#

class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_one :notice, as: :notifiable, dependent: :destroy

  after_create :create_notification

  def create_notification
    Notice.create!(user_id: post.user_id, notifiable: self)
  end
end

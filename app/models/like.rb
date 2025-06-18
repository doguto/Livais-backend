# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true

  validates :user_id, uniqueness: { scope: :post_id, message: "has already liked this post" }
end

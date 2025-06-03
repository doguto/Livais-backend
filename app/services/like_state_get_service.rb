class LikeStateGetService < ApplicationService
  def get_like(user_id:, post_id:)
    Like.find_by(user_id: user_id, post_id: post_id)
  end

  def liked_by_user?(user_id:, post_id:)
    Like.exists?(user_id: user_id, post_id: post_id)
  end
end

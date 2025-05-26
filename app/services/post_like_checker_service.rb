class PostLikeCheckerService
  def exists?(post_id:, user_id:)
    return false unless user_id

    Like.find_by(user_id: user_id, post_id: post_id)
  end
end

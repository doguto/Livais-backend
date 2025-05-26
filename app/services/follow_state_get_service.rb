class FollowStateGetService < ApplicationService
  def following_user?(user_id:, opponent_id:)
    user = User.find(user_id)
    return false unless user

    user.following.exists?(id: opponent_id)
  end
end

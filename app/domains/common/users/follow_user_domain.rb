module Common::Users
  class FollowUserDomain < ApplicationDomain
    def execute(followed_id:, follower_id: Current.current_user)
      Follow.find_or_create_by(follower_id: follower_id, followed_id: followed_id)
    end
  end
end

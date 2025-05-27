module Common::Users
  class UnfollowUserDomain < ApplicationDomain
    def execute(followed_id:, follower_id: Current.current_user)
      follow = Follow.find_by(follower_id: follower_id, followed_id: followed_id)
      follow&.destroy
    end
  end
end

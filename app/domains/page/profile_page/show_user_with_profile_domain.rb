module Page::ProfilePage
  class ShowUserWithProfileDomain < ApplicationDomain
    def initialize(user_id:)
      super()
      @user_id = user_id
    end

    def execute
      user = User.includes(:profile, :followers, :following).find(@user_id)

      {
        userId: user.id,
        user: {
          name: user.name,
          username: user.username,
          image: user.image,
          cover_image: user.profile&.cover_image,
          bio: user.profile&.bio,
          joinDate: user.created_at.strftime("%Y-%m-%d"),
          followCount: user.following.count,
          followerCount: user.followers.count
        }
      }
    end
  end
end

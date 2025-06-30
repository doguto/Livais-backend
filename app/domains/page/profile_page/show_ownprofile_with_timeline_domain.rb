module Page::ProfilePage
  class ShowOwnProfileWithTimelineDomain < ApplicationDomain
    def initialize(user:)
      super
      @user = user
    end

    def execute
      posts = @user.posts
        .includes(:likes, :replies, :current_user_likes, :current_user_reposts)
        .order(created_at: :desc)
        .limit(20)

      {
        profile: ProfileDto.new(@user),
        timeline: PostDto.from_collection(posts)
      }
    end
  end
end

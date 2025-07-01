module Page::ProfilePage
  class ShowUserWithProfileAndTimelineDomain < ApplicationDomain
    def initialize(viewer:, user:)
      super()
      @viewer = viewer
      @user = user
    end

    def execute
      posts = @user.posts
        .includes(:likes, :replies, :user, :quoted_post, :current_user_likes, :current_user_reposts)
        .order(created_at: :desc)
        .limit(20)

      timeline = PostDto.from_collection(posts, following_ids: @viewer.following_ids.to_set)

      {
        profile: ProfileDto.new(@user),
        timeline: timeline
      }
    end
  end
end

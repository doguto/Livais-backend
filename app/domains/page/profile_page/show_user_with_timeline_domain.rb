module Page::ProfilePage
  class ShowUserWithTimelineDomain < ApplicationDomain
    def initialize(user:)
      super()
      @user = user
    end

    def execute
      posts = @user.posts.includes(:likes, :replies).order(created_at: :desc).limit(20)

      {
        profile: ProfileDto.new(@user),
        timeline: PostDto.from_collection(posts)
      }
    end
  end
end

module Page::ProfilePage
  class ShowOwnProfileWithTimelineDomain < ApplicationDomain
    def initialize(user:)
      super()
      @user = user
    end

    def execute
      posts = @user.posts.includes(:likes, :replies).order(created_at: :desc).limit(20)
      {
        profile: ProfileDto.new(@user),
        timeline: posts.map { |post| PostDto.new(post) }
      }
    end
  end
end

module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def execute
      posts = Post.order(created_at: :desc).limit(50).includes(
        :user,
        :current_user_likes,
        :current_user_reposts
      )

      following_user_ids = following_ids_for

      PostDto.from_collection(posts, following_ids: following_user_ids)
    end
  end
end

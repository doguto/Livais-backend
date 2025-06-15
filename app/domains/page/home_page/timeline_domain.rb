module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def execute
      posts = Post.order(created_at: :desc).limit(50).includes(
        :user,
        :current_user_likes,
        :current_user_reposts,
        quoted_post: :user
      )

      current_user = Current.current_user

      following_user_ids = current_user ? current_user.following_ids_as_set : Set.new

      PostDto.from_collection(posts, following_ids: following_user_ids)
    end
  end
end

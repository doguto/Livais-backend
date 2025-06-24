module Page::HomePage
  class FollowTimelineDomain < ApplicationDomain
    def execute
      current_user = Current.current_user
      raise "User not found" unless current_user

      posts = Post.where(user: current_user).order(created_at: :desc).limit(50).includes(
        :user,
        :current_user_likes,
        :current_user_reposts,
        :parent_post,
        quoted_post: :user
      )
      posts.map do |post|
        PostDto.new(
          post,
          is_following_user: true,
          is_liked: post.current_user_likes.any?,
          is_reposted: post.current_user_reposts.any?
        )
      end
    end
  end
end

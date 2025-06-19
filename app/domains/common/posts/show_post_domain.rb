module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def execute(post_id:)
      post = Post.includes(
        :user,
        :current_user_likes,
        :current_user_reposts,
        :parent_post,
        quoted_post: :user,
        child_posts: [
          :user,
          :current_user_likes,
          :current_user_reposts,
          { quoted_post: :user }
        ]
      ).find(post_id)

      current_user = Current.current_user
      following_user_ids = current_user ? current_user.following_ids_as_set : Set.new

      is_liked = post.current_user_likes.any?
      is_reposted = post.current_user_reposts.any?
      is_following_user = following_user_ids.include?(post.user.id)

      reply_posts_dtos = PostDto.from_collection(post.child_posts, following_ids: following_user_ids)

      PostDetailDto.new(
        post: post,
        is_following_user: is_following_user,
        is_liked: is_liked,
        is_reposted: is_reposted,
        replies: reply_posts_dtos.map(&:get)
      )
    end
  end
end

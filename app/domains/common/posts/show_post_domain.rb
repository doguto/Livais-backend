module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def execute(post_id:)
      current_user = Current.current_user
      current_user_id = current_user&.id

      post = Post.includes(
        :user,
        :current_user_likes,
        :current_user_reposts,
        { replies: [
          :user, 
          :current_user_likes,
          :current_user_reposts
          ] }
      ).find(post_id)

      following_user_ids = if current_user
                             current_user.following.pluck(:id).to_set
                           else
                             Set.new
                           end

      is_liked_parent = post.likes.any?
      is_reposted_parent = post.reposts.any?
      is_following_parent_user = following_user_ids.include?(post.user.id)

      reply_posts_dtos = post.replies.order(created_at: :asc).map do |reply|
        is_liked_of_reply = reply.likes.any?
        is_reposted_of_reply = reply.reposts.any?
        is_following_reply = following_user_ids.include?(reply.user.id)

        PostDto.new(reply, is_following_user: is_following_reply, is_liked: is_liked_of_reply, is_reposted: is_reposted_of_reply)
      end

      PostDetailDto.new(
        post: post,
        is_following_user: is_following_parent_user,
        is_liked: is_liked_parent,
        is_reposted: is_reposted_parent,
        replies: reply_posts_dtos.map(&:get)
      )
    end
  end
end

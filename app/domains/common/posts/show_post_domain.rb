module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def execute(post_id:)
      current_user = Current.current_user
      current_user_id = current_user&.id

      post = Post.includes(
        :user,
        :reposts,
        :likes,
        { replies: [:user, :likes] }
      ).find(post_id)

      all_post_ids_in_context = [post.id] + post.replies.map(&:id)

      liked_post_ids_by_current_user = if current_user_id.present?
                                         Like.where(user_id: current_user_id, post_id: all_post_ids_in_context).pluck(:post_id).to_set
                                       else
                                         Set.new
                                       end

      following_user_ids_by_current_user = if current_user
                                             current_user.following.pluck(:id).to_set
                                           else
                                             Set.new
                                           end

      is_liked_by_current_user = liked_post_ids_by_current_user.include?(post.id)
      is_following_user = following_user_ids_by_current_user.include?(post.user.id)

      reply_posts_dtos = post.replies.order(created_at: :asc).map do |reply|
        is_following_reply = following_user_ids_by_current_user.include?(reply.user.id)
        is_liked_by_current_user_of_reply = liked_post_ids_by_current_user.include?(reply.id)

        PostDto.new(reply, is_following_user: is_following_reply, is_liked_by_current_user: is_liked_by_current_user_of_reply)
      end

      PostDetailDto.new(
        post: post,
        is_following_user: is_following_user,
        is_liked_by_current_user: is_liked_by_current_user,
        replies: reply_posts_dtos.map(&:get)
      )
    end
  end
end

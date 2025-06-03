module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def initialize
      super
      @follow_state_get_service = FollowStateGetService.new
      @like_state_get_service = LikeStateGetService.new
    end

    def execute(post_id:, current_user_id: nil)
      post = Post.includes(:user, :replies, :likes, :reposts).find(post_id)
      is_liked_by_current_user = @like_state_get_service.liked_by_user?(user_id: current_user_id, post_id: post.id)
      is_following_user = @follow_state_get_service.following_user?(user_id: current_user_id, opponent_id: post.user.id)

      reply_posts = post.replies.order(created_at: :asc).map do |reply|
        is_following_reply = @follow_state_get_service.following_user?(user_id: current_user_id, opponent_id: reply.user.id)
        is_liked_by_current_user_of_reply = @like_state_get_service.liked_by_user?(user_id: current_user_id, post_id: reply.id)
        PostDto.new(reply, is_following_user: is_following_reply, is_liked_by_current_user: is_liked_by_current_user_of_reply).get
      end

      PostDetailDto.new(post: post, is_following_user: is_following_user, is_liked_by_current_user: is_liked_by_current_user, replies: reply_posts)
    end
  end
end

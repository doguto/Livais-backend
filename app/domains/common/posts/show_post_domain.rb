module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def initialize
      super
      @follow_state_get_service = FollowStateGetService.new
      @post_like_checker_service = PostLikeCheckerService.new
    end

    def execute(post_id:, current_user_id: Current.current_user&.id)
      post = Post.includes(:user, :replies, :likes, :reposts).find(post_id)
      liked = @post_like_checker_service.exists?(post_id: post.id, user_id: current_user_id)
      is_following_post = @follow_state_get_service.following_user?(user_id: current_user_id, opponent_id: post.user.id)

      reply_posts = post.replies.order(created_at: :asc).map do |reply|
        is_following_reply = @follow_state_get_service.following_user?(user_id: current_user_id, opponent_id: reply.user.id)
        PostDto.new(reply, is_following_user: is_following_reply, current_user_id: current_user_id).get
      end

      PostDetailDto.new(post: post, is_following_user: is_following_post, current_user: Current.current_user, liked_by_current_user: liked, replies: reply_posts)
    end
  end
end

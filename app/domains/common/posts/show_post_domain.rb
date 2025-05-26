module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def initialize
      super
      @follow_state_get_service = FollowStateGetService.new
    end

    def execute(post_id:, current_user_id: 1)
      post = Post.includes(:user, :replies, :likes, :reposts).find(post_id)
      liked = PostLikeCheckerService.new.exists?(post_id: post.id, user_id: current_user&.id)
      is_following = @follow_state_get_service.following_user?(current_user_id, post.user.id)
      PostDetailDto.new(post: post, is_following: is_following, current_user_id: current_user_id, liked: liked)
    end
  end
end

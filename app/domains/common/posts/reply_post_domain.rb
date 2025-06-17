module Common::Posts
  class ReplyPostDomain < ApplicationDomain
    def initialize
      super
      @follow_state_get_service = FollowStateGetService.new
    end

    def execute(content:, reply_to_id:)
      user = Current.current_user
      post = Post.new(user: user, content: content, reply_to_id: reply_to_id)
      replied_post = Post.find(reply_to_id)
      is_following_user = @follow_state_get_service.following_user?(user_id: @user_id, opponent_id: replied_post.user_id)
      if post.save
        PostDto.new(post: post, is_following_user: is_following_user)
      else
        raise DomainError, post.errors.full_messages.join(", ")
      end
    end
  end
end

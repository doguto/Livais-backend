module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def initialize
      super
      @follow_state_get_service = FollowStateGetService.new
    end

    def execute(current_user_id: 1)
      # 仮に現在のUserをid=1としている
      user = User.find(current_user_id)
      posts = Post.order(created_at: :desc).limit(50)
      dtos = []
      posts.each do |post|
        is_following_user = @follow_state_get_service.following_user?(user_id: user.id, opponent_id: post.user_id)
        dto = PostDto.new(post, is_following_user: is_following_user)
        dtos.push(dto)
      end

      dtos
    end
  end
end

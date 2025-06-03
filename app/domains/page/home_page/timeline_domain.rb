module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def initialize
      super
      @follow_state_get_service = FollowStateGetService.new
      @like_state_get_service = LikeStateGetService.new
    end

    def execute(current_user_id: nil)
      user = current_user_id.present? ? User.find_by(id: current_user_id) : nil

      posts = Post.order(created_at: :desc).limit(50).includes(:user)

      dtos = []
      posts.each do |post|
        is_following_user = if user 
                              @follow_state_get_service.following_user?(user_id: user.id, opponent_id: post.user_id)
                            else
                              false
                            end

        is_liked_by_current_user = if user 
                                     @like_state_get_service.liked_by_user?(user_id: user.id, post_id: post.id)
                                   else
                                     false
                                   end

        dto = PostDto.new(post, is_following_user: is_following_user, is_liked_by_current_user: is_liked_by_current_user)
        dtos.push(dto)
      end

      dtos
    end
  end
end
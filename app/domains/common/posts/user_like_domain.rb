module Common::Posts
  class UserLikeDomain < ApplicationDomain
    def execute(user_id:, post_id:)
      like = LikeStateGetService.new.get_like(user_id: user_id, post_id: post_id)
      if like
        like.destroy
      else
        Like.create(user_id: user_id, post_id: post_id)
      end
      true
    end
  end
end

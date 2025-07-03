module Common::Posts
  class UserLikeDomain < ApplicationDomain
    def execute(post_id:)
      user = Current.current_user
      user_id = user&.id
      like = Like.find_by(user_id: user_id, post_id: post_id)
      if like
        like.destroy
      else
        Like.create(user_id: user_id, post_id: post_id)
      end
      true
    end
  end
end

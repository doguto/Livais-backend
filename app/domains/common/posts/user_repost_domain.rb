module Common::Posts
  class UserRepostDomain < ApplicationDomain
    def execute(post_id:)
      user = Current.current_user
      user_id = user&.id
      repost = Repost.find_by(user_id: user_id, post_id: post_id)
      if repost
        repost.destroy
      else
        Repost.create(user_id: user_id, post_id: post_id)
      end

      true
    end
  end
end

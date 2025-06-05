module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def execute
      user = Current.current_user
      user_id = user&.id

      posts = Post.order(created_at: :desc).limit(50).includes(
        :user,
        :current_user_likes,
        :current_user_reposts
      )

      following_user_ids = if user
                             user.following.pluck(:id).to_set
                           else
                             Set.new
                           end

      posts.map do |post|
        is_following_user = following_user_ids.include?(post.user_id)

        is_liked = post.current_user_likes.any? 
        is_reposted = post.current_user_reposts.any?

        PostDto.new(
          post,
          is_following_user: is_following_user,
          is_liked: is_liked,
          is_reposted: is_reposted
        )
      end
    end
  end
end

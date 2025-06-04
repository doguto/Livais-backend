module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def execute
      user = Current.current_user
      user_id = user&.id

      posts = Post.order(created_at: :desc).limit(50).includes(
        :user,
        :likes,
        :reposts
      )

      following_user_ids = if user
                             user.following.pluck(:id).to_set
                           else
                             Set.new
                           end

      posts.map do |post|
        is_following_user = following_user_ids.include?(post.user_id)

        is_liked = if user_id.present?
                     post.likes.any? { |like| like.user_id == user_id }
                   else
                     false
                   end

        is_reposted = if user_id.present?
                        post.reposts.any? { |repost| repost.user_id == user_id }
                      else
                        false
                      end

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

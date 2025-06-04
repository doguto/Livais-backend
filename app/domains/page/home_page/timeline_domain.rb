module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def execute
      user = Current.current_user
      user_id = user&.id

      posts = Post.order(created_at: :desc).limit(50).includes(
        :user,
        :likes
      )

      following_user_ids = if user
                             user.following.pluck(:id).to_set
                           else
                             Set.new
                           end

      posts.map do |post|
        is_following_user = following_user_ids.include?(post.user_id)

        is_liked_by_current_user = if user_id.present?
                                     post.likes.any? { |like| like.user_id == user_id }
                                   else
                                     false
                                   end

        is_reposted_by_current_user = if user_id.present?
                                        post.reposts.any? { |repost| repost.user_id == user_id }
                                      else
                                        false
                                      end

        PostDto.new(
          post,
          is_following_user: is_following_user,
          is_liked_by_current_user: is_liked_by_current_user,
          is_reposted_by_current_user: is_reposted_by_current_user
        )
      end
    end
  end
end

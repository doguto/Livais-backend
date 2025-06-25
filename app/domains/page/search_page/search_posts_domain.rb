module Page::SearchPage
  class SearchPostsDomain < ApplicationDomain
    def execute(query)
      return Post.none if query.blank?

      posts = Post.where("content LIKE ?", "%#{query}%").includes(
        :user,
        :current_user_likes,
        :current_user_reposts,
        :parent_post,
        quoted_post: :user
      )

      current_user = Current.current_user

      following_user_ids = current_user ? current_user.following_ids_as_set : Set.new

      PostDto.from_collection(posts, following_ids: following_user_ids)
    end
  end
end

module Common::Posts
  class UserQuoteDomain < ApplicationDomain
    def execute(content:, quoted_post_id:)
      user = Current.current_user
      quoted_post = Post.find(quoted_post_id)

      post = Post.new(user: user, content: content, quoted_post: quoted_post, quoted_post_id: quoted_post.id)
      if post.save
        post
      else
        raise DomainError, post.errors.full_messages.join(", ")
      end
    end
  end
end

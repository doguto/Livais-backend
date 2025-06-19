module Common::Posts
  class UserPostDomain < ApplicationDomain
    def execute(content:)
      user = Current.current_user
      post = Post.new(user: user, content: content)
      if post.save
        post
      else
        raise DomainError, post.errors.full_messages.join(", ")
      end
    end
  end
end

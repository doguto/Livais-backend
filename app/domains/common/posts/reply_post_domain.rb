module Common::Posts
  class ReplyPostDomain < ApplicationDomain
    def execute(content:, reply_to_id:)
      user = Current.current_user
      post = Post.create!(user: user, content: content)
      replied_post = Post.find(reply_to_id)

      is_following_user = user.following.exists?(id: replied_post.user_id)

      Reply.create(parent_post_id: reply_to_id, child_post_id: post.id)
      PostDto.new(post, is_following_user: is_following_user)
    rescue StandardError => e
      Rails.logger.debug { "💥 Exception raised: #{e.class} - #{e.message}" }
      Rails.logger.debug e.backtrace.join("\n")
      raise e
    end
  end
end

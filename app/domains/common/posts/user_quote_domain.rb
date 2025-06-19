module Common::Posts
  class UserQuoteDomain < ApplicationDomain
    def execute(content:, quoted_post_id:)
      user = Current.current_user
      quoted_post = Post.find(quoted_post_id)

      post = Post.create!(user: user, content: content)
      Quote.create!(quoted_post: quoted_post, quoting_post: post)

      post
    rescue StandardError => e
      Rails.logger.debug { "💥 Exception raised: #{e.class} - #{e.message}" }
      Rails.logger.debug e.backtrace.join("\n")
      raise e
    end
  end
end

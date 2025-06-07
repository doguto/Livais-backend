module Common::AiUsers
  class AiReplyDomain < ApplicationDomain
    def initialize
      super
      @gpt_service = ChatGPTService.new
    end

    def execute(post_id)
      # post_idを元にPostを取得し、ユーザー情報を取得する
      post = Post.find(post_id)
      ai_user = AiUser.order("RANDOM()").first

      # ユーザー情報を元に、ChatGPTにリプライ文を生成させるリクエストを投げる
      content = @gpt_service.chat(user_prompt: post.content)

      # 生成されたリプライ文を元に、ReplyのPostを生成して保存
      reply_post = Post.new(user: ai_user.user, content: content)
      reply_post.save!
    end
  end
end

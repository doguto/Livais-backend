module Common::AiUsers
  class AiPostDomain < ApplicationDomain
    def initialize
      super
      @gpt_service = GptService.new
    end

    def execute(_user_id)
      ai_user = AiUser.order("RANDOM()").first
      prompt = "人間が興味を持つようなSNS投稿を考えてください。"
      content = @gpt_service.chat(user_prompt: prompt)
      post = Post.new(user: ai_user.user, content: content)
      post.save!
    end
  end
end

module Common::AiUsers
  class AiPostDomain < ApplicationDomain
    include ChatGptModule

    def execute(_user_id)
      ai_user = AiUser.order("RANDOM()").first
      prompt = "人間が興味を持つようなSNS投稿を考えてください。"
      content = get_gpt_response(user_prompt: prompt)
      post = Post.new(user: ai_user.user, content: content)
      post.save!
    end
  end
end

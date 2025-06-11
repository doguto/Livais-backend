require_relative "test_domain"

class TestAIPostDomain < TestDomain
  def initialize
    super
    @gpt_service = GptService.new
  end

  def test_ai_post(post_text:)
    reply_text = @gpt_service.chat(user_prompt: post_text)
    Rails.logger.info "生成されたAIポスト: #{reply_text}"
    @answer = reply_text
  end
end

if __FILE__ == $PROGRAM_NAME
  test_ai_post_domain = TestAIPostDomain.new
  test_ai_post_domain.test_ai_post(post_text: "今日はパスタを作ったけど、アレンジ方法を考え中。何かアイデアある？")
end

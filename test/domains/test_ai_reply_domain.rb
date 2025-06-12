require_relative "test_domain"

class TestAIReplyDomain < TestDomain
  def initialize
    super

    @gpt_service = GptService.new
  end

  def test_ai_reply(post_text:)
    reply_text = @gpt_service.chat(user_prompt: post_text)
    Rails.logger.info reply_text

    @answer = reply_text
  end
end

if __FILE__ == $PROGRAM_NAME
  test_ai_reply_domain = TestAIReplyDomain.new
  test_ai_reply_domain.test_ai_reply(post_text: "昨日カレー作ってさ、炊飯器に1.5人前くらい残ってて、夫がおかわりしたいって言ったのよ。でも息子2人もおかわりしたそうだったのよ。だから夫に「冷凍ご飯で食べてくれる？」って提案したら心底理解できないみたいな顔されたんだけど、意味わかる？わたしは子どもに炊飯器のご飯譲るの。親だから。")
end

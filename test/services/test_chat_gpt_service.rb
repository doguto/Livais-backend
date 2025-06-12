require_relative "../../app/services/gpt_service"
require "logger"

class TestChatGptService
  def initialize
    @service = GptService.new
  end

  def test_chat_gpt_service
    # Test the service with a sample prompt
    prompt = "店長「このクソ忙しいGW中にシフトに入れないなんて責任感が足りない! お前らは大切な仕事を片手間程度に考えてるのか!?」

アルバイト店員「そもそも個人の都合に合わせて片手間程度で働くのがバイトなんで、社員レベルの仕事と責任感を求めるなら社員レベルの給料を払うか、社員を雇ってください」"
    response = @service.chat(user_prompt: prompt)

    # Check if the response is not nil and contains expected content
    Rails.logger.warn("Responce: #{response}")
  end
end

if __FILE__ == $PROGRAM_NAME
  service = TestChatGptService.new
  service.test_chat_gpt_service
end

require "openai"
require_relative "application_service"

class GptService < ApplicationService
  def initialize
    super

    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY", nil))
  end

  # @param [String] user_prompt
  # @param [String] system_prompt
  def chat(user_prompt:, system_prompt: "あなたはツイッターのユーザーです。ポストに対し、100字以内で返信のツイートをしてください。丁寧語や敬語は不要。記号やマークダウン形式（**など）は使用しないで。")
    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: user_prompt }
        ],
        max_tokens: 500,
        temperature: 0.7
      }
    )

    @answer = if response["choices"] && response["choices"][0] && response["choices"][0]["message"]
                response["choices"][0]["message"]["content"]
              else
                "申し訳ありませんが、回答を生成できませんでした。もう一度お試しください。"
              end
  end
end

if __FILE__ == $PROGRAM_NAME
  service = GptService.new
  prompt = "railsにクリーンアーキテクチャ拒絶された…"
  Rails.logger.info service.chat(prompt)
end

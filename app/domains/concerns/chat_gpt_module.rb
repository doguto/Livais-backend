module ChatGptModule
  DEFAULT_USER_PROMPT = "あなたはツイッターのユーザーです。ポストに対し、100字以内で返信のツイートをしてください。丁寧語や敬語は不要。記号やマークダウン形式（**など）は使用しないで。".freeze

  def chat(user_prompt:, system_prompt: DEFAULT_USER_PROMPT)
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY", nil))

    response = client.chat(
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

    if response["choices"] && response["choices"][0] && response["choices"][0]["message"]
      response["choices"][0]["message"]["content"]
    else
      "申し訳ありませんが、回答を生成できませんでした。もう一度お試しください。"
    end
  end
end

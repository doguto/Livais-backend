class Posts::RepliesController < ApplicationController
  def create
    dto = Common::Posts::ReplyPostDomain.new.execute(
      content: params[:content],
      reply_to_id: params[:post_id]
    )
    render json: dto.get.to_camelized_json, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User or Post not found" }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end

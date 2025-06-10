class Posts::LikesController < ApplicationController
  def create
    successon = Common::Posts::UserLikeDomain.new.execute(post_id: params[:post_id])

    render json: { message: "Success" }, status: :ok if successon
  rescue StandardError => e
    render json: { message: e.message }, status: :unprocessable_entity
  end
end

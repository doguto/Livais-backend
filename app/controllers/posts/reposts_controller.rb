class Posts::RepostsController < ApplicationController
  def create
    result = Common::Posts::UserRepostDomain.new.execute(post_id: params[:post_id])
    if result
      render json: { success: true }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end
end

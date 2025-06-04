class PostsController < ApplicationController
  def index
    dtos = Page::HomePage::TimelineDomain.new.execute
    render json: dtos.map(&:get).as_json
  end

  def show
    post = Common::Posts::ShowPostDomain.new.execute(post_id: params[:id])
    render json: post.get.as_json
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
  end

  def create
    post = Common::Posts::UserPostDomain.new(user_id: params[:post][:user_id]).execute(content: params[:post][:content])
    render json: post.as_json.camelize, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def user_posts
    posts = Common::Posts::FetchUserPostsDomain.new(user_id: params[:user_id]).execute
    render json: posts.map { |post| post.get.to_camelized_json }.as_json
  end

  private

  def post_params
    params.expect(post: [:content, :user_id])
  end
end

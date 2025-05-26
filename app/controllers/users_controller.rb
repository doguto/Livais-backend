class UsersController < ApplicationController
  def show
    user = Page::ProfilePage::ShowUserWithProfileDomain.new(user_id: params[:id]).execute
    render json: user.as_json(include: :profile, except: :password_digest).camelize
  end

  def create
    result = Common::Users::CreateUserDomain.new(params: user_params).execute
    if result.success?
      render json: result.user.as_json.camelize, status: :created
    else
      render json: { errors: result.errors }.camelize, status: :unprocessable_entity
    end
  end

  def follow
    Common::Users::FollowUserDomain.new(follower_id: current_user.id, followed_id: params[:id]).execute
    head :no_content
  end

  def unfollow
    Common::Users::UnfollowUserDomain.new(follower_id: current_user.id, followed_id: params[:id]).execute
    head :no_content
  end

  def followers
    users = Page::ProfilePage::FollowersGetDomain.new(user_id: params[:id]).execute
    render json: users.as_json.camelize
  end

  def following
    users = Page::ProfilePage::FollowsGetDomain.new(user_id: params[:id]).execute
    render json: users.as_json.camelize
  end

  private

  def user_params
    params.expect(user: [:name, :email, :password, :image])
  end
end

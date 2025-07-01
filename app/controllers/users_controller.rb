class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    dto = Page::ProfilePage::ShowUserWithProfileAndTimelineDomain
      .new(viewer: Current.current_user, user: user)
      .execute

    render json: {
      profile: dto[:profile].get,
      timeline: dto[:timeline].map(&:get)
    }, status: :ok
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
    Common::Users::FollowUserDomain.new.execute(followed_id: params[:id])
    head :no_content
  end

  def unfollow
    Common::Users::UnfollowUserDomain.new.execute(followed_id: params[:id])
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

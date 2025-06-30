module Api
  class ProfilesController < ApplicationController
    before_action :require_login, only: [:me, :show]

    def me
      dto = Page::ProfilePage::ShowOwnProfileWithTimelineDomain
        .new(user: Current.current_user)
        .execute

      render_profile_and_timeline(dto)
    end

    def show
      user = User.find_by(id: params[:user_id])
      return head :not_found unless user

      dto = Page::ProfilePage::ShowUserWithTimelineDomain
        .new(viewer: Current.current_user, user: user)
        .execute

      render_profile_and_timeline(dto)
    end

    private

    def require_login
      head :unauthorized unless Current.current_user
    end

    def render_profile_and_timeline(dto)
      render json: {
        profile: dto[:profile].to_h,
        timeline: dto[:timeline].map(&:to_h)
      }, status: :ok
    end
  end
end

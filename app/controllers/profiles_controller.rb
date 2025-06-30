module Api
  module V1
    class ProfilesController < ApplicationController
      def show
        user = User.find(params[:user_id])
        dto = Page::ProfilePage::ShowUserWithTimelineDomain.new(user: user).execute

        render json: {
          profile: dto[:profile].to_h,
          timeline: dto[:timeline].map(&:to_h)
        }, status: :ok
      end
    end
  end
end
